class Widget < ActiveRecord::Base
  attr_accessible :project_id, :user_id, :url, :size, :background_color

  belongs_to :user
  validates :url, presence: true
  has_many :clicks
  has_many :showings

  def total_clicks
    clicks.count
  end

  def total_showings
    showings.count
  end

  def method_missing(meth, *args, &blk)
    if project_data.has_key?(meth.to_s)
      project_data[meth.to_s]
    else
      super
    end
  end

  def funding_needed
    total_price.to_f - cost_to_complete.to_f
  end

  def school_split
    school.split(" ")
  end

  def formatted_school
    school_split[-1]
  end

  def formatted_name
    school_split[0...-1].join("")
  end

  def pid
    @pid ||= DonorsChoose::Project.parse_id_from_url(url)
  end

  private

  def data
    REDIS.get(pid)
  end

  def data= (new_data)
    REDIS.set(pid, new_data)
  end

  def project_data
    update_cache unless cache_current?
    JSON.parse(data)
  end

  def cache_current?
    (JSON.parse(data)["cache_expires"].to_datetime >= DateTime.now) rescue false
  end

  def is_tint?
    background_color
    red = background_color[1] + background_color[2]
    green = background_color[3] + background_color[4]
    blue = background_color[5] + background_color[6]
    total = red.to_i(16) + blue.to_i(16) + green.to_i(16)
    total > 383 ? true : false
  end

  def update_cache
    project = DonorsChoose::Project.by_url(url)
    self.data = {
      :pid => project.id,
      :proposal_url => project.proposalURL,
      :fund_url => project.fundURL,
      :image_url => project.imageURL,
      :title => project.title,
      :short_description => project.shortDescription,
      :fulfillment_trailer => project.fulfillmentTrailer,
      :percent_funded => project.percentFunded,
      :cost_to_complete => project.costToComplete,
      :total_price => project.totalPrice,
      :teacher_name => project.teacherName,
      :grade_level => project.gradeLevel['name'],
      :poverty_level => project.povertyLevel,
      :school => project.schoolName,
      :city => project.city,
      :zip => project.zip,
      :state => project.state,
      :latitude => project.latitude,
      :longitude => project.longitude,
      :subject => project.subject['name'],
      :resource => project.resource['name'],
      :expiration_date => project.expirationDate,
      :funding_status => project.fundingStatus,
      :cache_expires => DateTime.now + 30.seconds
    }.to_json
  end
end