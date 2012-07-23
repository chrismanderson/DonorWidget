class WidgetStepsController < ApplicationController
  include Wicked::Wizard

  steps :project, :size, :color, :finish

  def show
    @widget = Widget.last
    case step
    when :project
      @widget = Widget.new
    end
    render_wizard
  end

  def update
    @widget = Widget.last
    case step
    when :project
      @widget = Widget.create(params[:widget])
    end
    @widget.attributes = params[:widget]
    render_wizard @widget
  end

  def finish_wizard_path
    widget_path(@widget)
  end
end
