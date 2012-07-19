class WidgetStepsController < ApplicationController
	include Wicked::Wizard

	steps :size, :color, :finish

	def show
		@widget = current_user.widgets.last
		render_wizard
	end

	def update
		@widget = current_user.widgets.last
    @widget.attributes = params[:widget]
    render_wizard @widget
	end

end
