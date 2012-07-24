class ClicksController < ApplicationController
  respond_to :json

  def create
    REDIS.lpush("widget_#{params['widget_id']}_clicks", Time.new)
    render :json => { :status => :ok }
  end
end
