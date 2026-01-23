class TodosController < ApplicationController
  before_action :set_todo, only: [ :edit, :update, :destroy ]

  def index
    @q = current_user.todos.ransack(params[:q])
    @todos = @q.result.order(created_at: :desc).page(params[:page])
  end

  def new
    @todo = current_user.todos.new
  end

  def create
    @todo = current_user.todos.new(todo_params)
    if @todo.save
      respond_to do |format|
        format.html { redirect_to todos_path, notice: "Todo created successfully!" }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @todo.update(todo_params)
      respond_to do |format|
        format.html { redirect_to todos_path, notice: "Todo updated successfully!" }
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to todos_path, notice: "Todo deleted successfully!" }
      format.turbo_stream
    end
  end

  private

  def set_todo
    @todo = current_user.todos.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :description, :completed)
  end
end
