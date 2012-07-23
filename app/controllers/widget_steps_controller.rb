class WidgetStepsController < ApplicationController
  include Wicked::Wizard

  steps :project, :size, :color, :finish

  def show
    @widget = (step == :project) ?
      Widget.new :
      Widget.find_by_id(cookies[:widget_id])
    render_wizard
  end

  def update
    @widget = (step == :project) ?
      Widget.create(params[:widget]) :
      Widget.find_by_id(cookies[:widget_id]).tap do |w|
        w.attributes = params[:widget]
        w.save
    end
    cookies[:widget_id] = @widget.id
    render_wizard @widget
  end

  def finish_wizard_path
    widget_path(@widget)
  end
end
