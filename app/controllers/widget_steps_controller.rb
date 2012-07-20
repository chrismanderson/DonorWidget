class WidgetStepsController < ApplicationController
	include Wicked::Wizard

	steps :project, :size, :color, :finish
	
	def show
		case step	
		when :project
		  @widget = Widget.new
		else
			@widget = current_user.widgets.last
		end
		render_wizard(@wizard)
	end

	def update
		case step
		when :project
			@widget = Widget.create(params[:widget])
		else
			@widget = current_user.widgets.last
	    @widget.update_attributes(params[:widget])
		end
    render_wizard(@widget)
	end

	def finish_wizard_path
	  widget_path(@widget)
	end

end
