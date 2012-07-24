class ClicksController < ApplicationController
  respond_to :json

  def create
    @widget = Widget.find(params['widget_id'])
    @widget.add_click
    # REDIS.lpush("widget_#{params['widget_id']}_clicks", Time.new)
    render :json => { :status => :ok }
  end
end
