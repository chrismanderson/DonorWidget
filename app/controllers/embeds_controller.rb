class EmbedsController < ApplicationController
  def show
    @widget = Widget.find(params[:id])
    @widget.showings.create!
    @widget.increment_show_count
    render layout: false
  end

  def to_string
    @widget = Widget.find(cookies[:widget_id])
    @content = render_to_string(partial: "embeds/widget", locals: {widget: @widget}, layout: false )
  end
end
