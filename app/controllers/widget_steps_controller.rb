class WidgetStepsController < ApplicationController
	include Wicked::Wizard

	steps :project, :size, :color, :finish

	def show
		case step
		when :project
			@widget = Widget.new
		end
		@widget = current_user.widgets.last
		render_wizard
	end

	def update
		@widget = current_user.widgets.last
    @widget.attributes = params[:widget]
    render_wizard(@widget)
	end

	def finish_wizard_path
	  render 'wizard_steps/finish'
	end

end
