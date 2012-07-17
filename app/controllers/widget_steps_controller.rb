class WidgetStepsController < ApplicationController
	include Wicked::Wizard

	steps :size, :customize, :finish

	def show
		render_wizard
	end

end
