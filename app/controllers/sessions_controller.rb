# 로그인 세션 관리용 컨트롤러
class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :new, :create ]
  # 로그인 페이지 렌더링
  # views/sessions/new.html.erb 렌더링 (로그인 폼 만들어야 함)
  def new
  end

  # 로그인 처리
  # 사용자가 아이디/비번을 입력하고 '로그인' 버튼을 눌렀을 때 실행
  # 로그인 정보가 정확한지 확인하고 세션에 사용자 ID 저장
  # 로그인 성공 시 root_path(메인 페이지)로 리다이렉트
  # 로그인 실패 시 new_path(로그인 페이지)로 리다이렉트
  def create
    # 1. 사용자가 입력한 아이디(params[:login_id])로 사용자(User) 찾기
    user = User.find_by(login_id: params[:login_id])
    # 2. 유저가 존재하고(&.), 입력한 비밀번호가 맞다면(authenticate)
    if user&.authenticate(params[:password])
      # [핵심] 로그인 성공! 세션 저장소에 유저 ID를 저장합니다.
      # 이제 브라우저는 이 쿠키를 들고 다니며 "나 로그인한 사람이야"라고 증명합니다.
      session[:user_id] = user.id
      # 3. 로그인 성공 시 root_path(메인 페이지)로 리다이렉트
      redirect_to root_path, notice: "Logged in successfully!"
    else
      # 4. 로그인 실패 시 new_path(로그인 페이지)로 리다이렉트
      flash.now[:alert] = "Invalid login ID or password"
      # 입력했던 화면(new)을 다시 보여줍니다.
      # status: :unprocessable_entity (422)는 Turbo가 에러를 감지하고 화면을 갱신하기 위해 꼭 필요합니다!
      render :new, status: :unprocessable_entity
    end
  end

  # 로그아웃 처리
  # 세션에서 사용자 ID 제거
  # 로그아웃 성공 시 login_path(로그인 페이지)로 리다이렉트
  def destroy
    # [핵심] 세션에서 유저 ID를 지워버립니다.
    session[:user_id] = nil
    # 로그인 페이지로 리다이렉트
    redirect_to login_path, notice: "Logged out successfully!"
  end
end
