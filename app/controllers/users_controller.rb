class UsersController < ApplicationController
  # 회원가입 페이지는 로그인하지 않은 사용자도 접근 가능하도록 설정
  skip_before_action :authenticate_user!, only: [ :new, :create ]

  # 회원가입 화면
  def new
    @user = User.new
  end

  # 회원가입 처리
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Welcome! Account created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # 프로필 수정 폼 (Modal)
  def edit
    @user = current_user
  end

  # 프로필 업데이트 처리
  def update
    @user = current_user
    if @user.update(user_params)
      respond_to do |format|
        format.turbo_stream do
          # 아바타만 변경된 경우 (파일 업로드) -> 모달 내용만 교체 (유지)
          if user_params[:avatar].present? && user_params.keys.size == 1
             render turbo_stream: turbo_stream.replace("profile-modal", partial: "users/profile_modal")
          else
             # 이름/소개 등 저장 버튼 클릭 시 -> 모달 닫고 이동
             redirect_to root_path, notice: "Profile updated successfully!"
          end
        end
        format.html { redirect_to root_path, notice: "Profile updated successfully!" }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # 회원가입 파라미터
  def user_params
    params.require(:user).permit(:login_id, :password, :password_confirmation, :user_name, :avatar, :bio)
  end
end
