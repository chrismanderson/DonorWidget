class ProjectsController < ApplicationController
  respond_to :json

  def random
    projects = DonorsChoose::Project.by_poverty_level(true)
    url = donors_url(projects.sample)
    render :json => { 'url' => url}
  end

  def show
    project = DonorsChoose::Project.by_id(params[:id])
    if project
      render :json => { :status => :success }
    else
      render :json => { :status => :bad_request }
    end
  end

  private

  def donors_url project
    url = project.proposalURL
    url = url.split('/')[0..5].join('/')
  end
end
