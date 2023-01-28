class TasksController < ApplicationController

  def index
    if params[:sort_deadline]
      @tasks = @current_user.tasks.order(deadline: "DESC").page(params[:page])
    elsif params[:sort_priority]
      @tasks = @current_user.tasks.order(priority: "ASC").page(params[:page])
      # binding.irb
    else
      @tasks = @current_user.tasks.order(created_at: "DESC").page(params[:page])
    end

    if params[:task].present?
      if params[:task][:title].present? && params[:task][:status].present?
        @tasks = @current_user.tasks.scope_title(params[:task][:title]).page(params[:page])
        @tasks = @current_user.tasks.scope_status(params[:task][:status]).page(params[:page])
      elsif params[:task][:title].present?
        @tasks = @current_user.tasks.scope_title(params[:task][:title]).page(params[:page])
      elsif params[:task][:status].present?
        @tasks = @current_user.tasks.scope_status(params[:task][:status]).page(params[:page])
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
    @task.user_id = @current_user.id
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
    @task = Task.find(params[:id])
    if @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました！"
    end
  end

  private
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:id, :title, :to_do, :deadline, :status, :priority, label_ids: [] )
  end
end