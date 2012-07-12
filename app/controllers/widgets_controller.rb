class WidgetsController < ApplicationController
  respond_to :json

  def show
    @project = Project.first
  end

end
