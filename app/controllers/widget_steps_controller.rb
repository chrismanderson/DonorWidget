class WidgetStepsController < ApplicationController
  include Wicked::Wizard
  before_filter :find_or_create_widget_from_params, only: :update

  layout "wizard"

  steps :project, :size, :color, :finish

  def show
    @widget = (step == :project) ?
      Widget.new :
      Widget.find_by_id(cookies[:widget_id])
    render_wizard
  end

  def update
    cookies[:widget_id] = @widget.id
    render_wizard @widget
  end

  def finish_wizard_path
    widget_path(@widget)
  end

  private

  def find_or_create_widget_from_params
    @widget = (step == :project) ?
      Widget.create(params[:widget]) :
      Widget.find_by_id(cookies[:widget_id]).tap do |widget|
        widget.attributes = params[:widget]
        widget.save
    end
  end
end
