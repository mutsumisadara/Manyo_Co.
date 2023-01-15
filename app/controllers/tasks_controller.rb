class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  def index
    @tasks = Task.all.order(created_at: "DESC")
    # binding.irb
   if params[:sort_deadline]
      @tasks = Task.all.order(deadline: "DESC")
  #  else
  #   @tasks = query
   end
  end

  def new
    @task = Task.new
  end

  def show
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    if params[:back]
      render :new
    elsif @task.save
      redirect_to tasks_path, notice: "新しいタスクを作成しました！"
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
    redirect_to @task, notice: "タスクを更新しました！"
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました！"
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:id, :title, :to_do, :deadline, :status, :priority)
  end

  # def query
  #   if params[:title].present? && params[:title][:to_do]
  #     Task.where('name LIKE ?', "%#{params[:title][:to_do]}%")
  #   else
  #     Task.all
  #   end
  # end
end