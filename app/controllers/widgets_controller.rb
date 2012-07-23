class WidgetsController < ApplicationController
  before_filter :find_widget, only: [:edit, :show, :update, :delete]

  def index
    @widgets = Widget.all
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
    @widget = Widget.create(params[:widget])
    if @widget.save
      cookies[:widget_id] = @widget.id
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
    @widget = Widget.find_by_id(cookies[:widget_id])
  end
end
