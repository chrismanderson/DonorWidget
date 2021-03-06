class WidgetsController < ApplicationController
  before_filter :find_widget, only: [:show]

  def show
    respond_to do |format|
      format.html
      format.json { @widget }
    end
  end

  private

  def find_widget
    @widget = Widget.find_by_id(params[:id])
  end
end
