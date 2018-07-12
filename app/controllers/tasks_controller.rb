class TasksController < ApplicationController
  
  def index
    @tasks = Task.all
  end
  
  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = "タスクの登録に成功しました！"
      redirect_to @task #showに飛ばす。
    else
      flash[:danger] = "タスクの登録に失敗しました！"
      render :new_task_path
    end
  end
  
  def new
    @task = Task.new
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)#updateは引数いるんやで
      flash[:success] = "タスクの更新に成功しました！"
      redirect_to @task #showに飛ばす
    else
      flash[:danger] = "タスクの更新に失敗しました！"
      render :edit_task_path #editに飛ばす
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = "タスクの削除が完了しました！"
    redirect_to tasks_url#indexに飛ばす(_urlやで)
  end
  
  private
  
  def task_params
    params.require( :task).permit( :content)
    #Taskモデルのフォームと明示
    #contentカラムのデータをフィルタリング
  end
  

end
