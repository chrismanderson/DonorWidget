class EmbedsController < ApplicationController
  def show
    @widget = Widget.find(params[:id])
    @widget.add_showing
    render layout: false
  end
end
