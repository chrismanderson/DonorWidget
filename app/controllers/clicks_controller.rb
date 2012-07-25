class ClicksController < ApplicationController
  respond_to :json

  def create
    @widget = Widget.find(params['widget_id'])
    @widget.add_click
    render :json => { :status => :ok }
  end
end
