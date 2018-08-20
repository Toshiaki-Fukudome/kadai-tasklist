class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in, except: [:index]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    #ページネーションの追加
    #@tasks = Task.all.page(params[:page]).per(5)
    #descで並び替え
    if logged_in?
      @tasks = current_user.tasks.order(created_at: :desc).page(params[:page]).per(5)
    end
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = "タスクの登録に成功しました！"
      redirect_to @task #showに飛ばす。
    else
      flash[:danger] = "タスクの登録に失敗しました！"
      render :new
    end
  end
  
  def new
    @task = Task.new
  end
  
  def show
    #@task = Task.find(params[:id])
    #set_task
  end
  
  def edit
    #@task = Task.find(params[:id])
    #set_task
  end
  
  def update
    #@task = Task.find(params[:id])
    #set_task
    
    if @task.update(task_params)#updateは引数いるんやで
      flash[:success] = "タスクの更新に成功しました！"
      redirect_to @task #showに飛ばす
    else
      flash[:danger] = "タスクの更新に失敗しました！"
      render :edit #editに飛ばす
    end
  end
  
  def destroy
    #@task = Task.find(params[:id])
    #set_task
    @task.destroy
    
    flash[:success] = "タスクの削除が完了しました！"
    redirect_to tasks_url#indexに飛ばす(_urlやで)
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require( :task).permit( :content, :status)
    #Taskモデルのフォームと明示
    #contentカラムのデータをフィルタリング
  end
  
  #ログインユーザにのみ操作を行わせるためのメソッド
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end

end
