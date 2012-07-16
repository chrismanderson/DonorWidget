class Widget < ActiveRecord::Base
  attr_accessible :project_id, :user_id, :url
  belongs_to :user

  validates :url, presence: true, uniqueness: true

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