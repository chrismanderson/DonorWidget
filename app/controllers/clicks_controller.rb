class ClicksController < ApplicationController
  respond_to :json

  def create
    REDIS.lpush("widget_#{params['widget_id']}_clicks", Time.new)
    # widget = Widget.find(params['widget_id'])
    # @click = Click.new(:widget_id => params['widget_id'])
    render :json => { :status => :ok }
  end
end
