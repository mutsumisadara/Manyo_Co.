class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    if params[:sort_deadline]
      @tasks = Task.all.order(deadline: "DESC")
    elsif params[:sort_priority]
      @tasks = Task.all.order(priority: "ASC")
      # binding.irb
    else
      @tasks = Task.all.order(created_at: "DESC")
    end

    if params[:task].present?
      if params[:task][:title].present? && params[:task][:status].present?
        @tasks = Task.scope_title(params[:task][:title])
        @tasks = Task.scope_status(params[:task][:status])
      elsif params[:task][:title].present?
        @tasks = Task.scope_title(params[:task][:title])
      elsif params[:task][:status].present?
        @tasks = Task.scope_status(params[:task][:status])
      # else @tasks.count == 0
      #   flash.now[:alert] = "見つかりませんでした。"
      end
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
end