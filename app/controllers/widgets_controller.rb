class WidgetsController < ApplicationController
  before_filter :login_required
  before_filter :find_widget, only: [:edit, :show, :update, :delete]

  def index
    @widgets = current_user.widgets
  end

  def edit
  end

  def show
    respond_to do |format|
      format.html
      format.json { @widget }
    end
  end

  def update
  end

  def delete
  end

  def create
    @widget = current_user.widgets.create(params[:widget])
    if @widget.save
      redirect_to widget_steps_path
    else
      render :new
    end
  end

  def new
    @widget = current_user.widgets.new
  end

  private

  def find_widget
    @widget = current_user.widgets.find(params[:id])
  end
end
