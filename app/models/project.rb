class Project < ActiveRecord::Base
  # attr_accessible :title, :body
  validates_presence_of :school

  def self.create_from_url url
  	api_project = DonorsChoose::Project.by_url(url)
  	project = Project.new
  	project.add_attrs_from_struct(api_project)
  	project.save
  end

  def add_attrs_from_struct api_project
  	self.pid = api_project.id
  	self.proposal_url = api_project.proposalURL
  	self.proposal_raw_url = raw_url(api_project.proposalURL)
  	self.fund_url = api_project.fundURL
  	self.image_url = api_project.imageURL
  	self.title = api_project.title
  	self.short_description = api_project.shortDescription
  	self.fulfillment_trailer = api_project.fulfillmentTrailer
  	self.percent_funded = api_project.percentFunded
  	self.cost_to_complete = api_project.costToComplete
  	self.total_price = api_project.totalPrice
  	self.teacher_name = api_project.teacherName
  	self.grade_level = api_project.gradeLevel['name']
  	self.poverty_level = api_project.povertyLevel
  	self.school = api_project.schoolName
  	self.city = api_project.city
  	self.zip = api_project.zip
  	self.state = api_project.state
  	self.latitude = api_project.latitude
  	self.longitude = api_project.longitude
  	self.subject = api_project.subject['name']
  	self.resource = api_project.resource
  	self.expiration_date = api_project.expirationDate
  	self.funding_status = api_project.fundingStatus
  end

  def raw_url donors_url
  	donors_url.split('/')[0..5].join('/')
  end
end
