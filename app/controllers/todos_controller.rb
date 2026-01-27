class TodosController < ApplicationController
  # set_todo를 edit, update, destroy에서 사용하기 위해 선언
  before_action :set_todo, only: [ :show, :edit, :update, :destroy ]

  def show
  end

  # 할 일 목록 조회
  def index
    @q = current_user.todos.ransack(params[:q])
    @view_mode = params[:view_mode] || "list" # 'list' 또는 'kanban'

    # Kanban 모드일 때는 페이지네이션 없이 모든 항목 조회
    if @view_mode == "kanban"
      @todos = @q.result.order(created_at: :desc)
    else
      per_page = [ 10, 25, 50 ].include?(params[:per_page].to_i) ? params[:per_page].to_i : 10
      @todos = @q.result.order(created_at: :desc).page(params[:page]).per(per_page)
    end
  end

  # 할 일 추가 화면
  def new
    @todo = current_user.todos.new
  end

  # 할 일 추가 처리
  def create
    @todo = current_user.todos.new(todo_params)
    if @todo.save
      redirect_to todos_path, notice: "Todo created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 할 일 수정 화면
  def edit
  end

  # 할 일 수정 처리
  def update
    if @todo.update(todo_params)
      redirect_to todos_path, notice: "Todo updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # 할 일 삭제 처리
  def destroy
    @todo.destroy
    redirect_to todos_path, notice: "Todo deleted successfully!", status: :see_other
  end

  private

  # 할 일 찾기
  def set_todo
    @todo = current_user.todos.find(params[:id])
  end

  # 할 일 파라미터
  def todo_params
    params.require(:todo).permit(:title, :description, :completed, :due_date, :priority, :status)
  end
end
