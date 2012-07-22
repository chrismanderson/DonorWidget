class EmbedsController < ApplicationController
  def show
    @widget = Widget.find(params[:id])
    @widget.showings.create!
  end

  def to_string
    @widget = Widget.find(params[:id])
    @content = render_to_string(:partial => "embeds/widget", :locals => { :widget => @widget}, :layout => false )
  end
end
