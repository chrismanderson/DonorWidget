class ClicksController < ApplicationController
  respond_to :json

  def create
    @click = Click.new(:widget_id => params['widget_id'])

    if @click.save
      respond_with(@click, :status => :created)
    else
      render :json => {errors: [@click.errors]}
    end
  end
end
