class Project < ActiveRecord::Base
  # attr_accessible :title, :body
  validates_presence_of :school

  def self.create_from_url url
  	api_project = DonorsChoose::Project.by_url(url)
  	project = Project.new
  	project.add_attrs_from_struct(api_project)
  end

  def add_attrs_from_struct api_project
  	self.project_id = api_project.id
  	puts self.inspect
  end
end
