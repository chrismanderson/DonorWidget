class Project < ActiveRecord::Base
  # attr_accessible :title, :body
  validates_presence_of :school

  def self.create_from_url url
  	api_project = DonorsChoose::Project.by_url(url)
  	project = Project.new
  	project.add_attrs_from_struct(api_project)
  	project
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
  	self.grade_level = api_project.gradeLevel
  	self.poverty_level = api_project.povertyLevel
  	self.school = api_project.schoolName

  	puts self.inspect
  end

  def raw_url donors_url
  	donors_url.split('/')[0..5].join('/')
  end
end
