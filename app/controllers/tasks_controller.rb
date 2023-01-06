class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:id, :title, :to_do)
  end
end