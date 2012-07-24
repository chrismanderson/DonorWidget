class Widget < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  include Cacher

  attr_accessible :project_id, :url, :size, :background_color

  validates :url, presence: true
  has_many :clicks
  has_many :showings

  def self.archive_clicks
    Widget.all.each do |widget|
      while click_time = widget.pop_click do
        click = widget.clicks.create
        click.update_attribute(:created_at, click_time.to_date)
      end
    end
  end

  def self.archive_showings
    Widget.all.each do |widget|
      while showing_time = widget.pop_showing do
        showing = widget.showings.create
        showing.update_attribute(:created_at, showing_time.to_date)
      end
    end
  end

  def redis_key
    "widget-#{pid}"
  end

  def click_key
    "widget_#{id}_clicks"
  end

  def showing_key
    "widget_#{id}_showings"
  end

  def font_color
    is_tint? ? 'black' : 'white'
  end

  def total_clicks
    clicks.count + count_list(click_key)
  end

  def total_showings
    showings.count + count_list(showing_key)
  end

  def cached_clicks
    get_list(click_key)
  end

  def cached_showings
    get_list(showing_key)
  end

  def add_showing
    push_list(showing_key, Time.new)
  end

  def add_click
    push_list(click_key, Time.new)
  end

  def pop_click
    pop_list(click_key)
  end

  def pop_showing
    pop_list(showing_key)
  end

  def embed_code
    "<script type='text/javascript' src='#{embed_url(self, format: :js, host: "#{RAW_URL}")}'></script>"
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
    (school_split[-1]).html_safe
  end

  def formatted_name
    (school_split[0...-1].join("")).html_safe
  end

  def pid
    @pid ||= DonorsChoose::Project.parse_id_from_url(url)
  end

  def is_funded?
    funding_status == 'funded' ? true : false
  end

  def is_tint?
    red = background_color[1..2]
    green = background_color[3..4]
    blue = background_color[5..6]
    total = red.to_i(16) + blue.to_i(16) + green.to_i(16)
    total > 383 ? true : false
  end

  private

  def project_data
    update_cache unless cache_current?
    JSON.parse(data)
  end 

  def update_cache
    project = DonorsChoose::Project.by_url(url)
    cache_data({ :pid => project.id,
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
      :funding_status => project.fundingStatus
    })
  end
end