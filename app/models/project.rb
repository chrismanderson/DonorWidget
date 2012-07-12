class Project < ActiveRecord::Base  
  include Projectable
  validates_presence_of :school
  validates_uniqueness_of :pid

  def self.create_from_url url
  	api_project = DonorsChoose::Project.by_url(url)
  	Project.create(build_from_struct(api_project))
  end

  def self.build_from_struct project
    {
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
    }
  end

  def funding_needed
    total_price - cost_to_complete
  end

  def raw_url donors_url
  	donors_url.split('/')[0..5].join('/')
  end
end
