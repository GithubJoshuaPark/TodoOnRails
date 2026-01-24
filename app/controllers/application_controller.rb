# ApplicationController
# 모든 컨트롤러가 상속받는 기본 컨트롤러
# 로그인 상태 관리용 메소드 정의

class ApplicationController < ActionController::Base
  # 모든 컨트롤러에서 authenticate_user!를 실행하도록 설정
  before_action :authenticate_user!
  before_action :refresh_session_expiration, if: :logged_in?

  # current_user와 logged_in?를 뷰에서도 사용할 수 있도록 설정
  helper_method :current_user, :logged_in?

  # 현재 로그인된 사용자 찾기
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # 로그인 여부 확인
  def logged_in?
    !!current_user
  end

  # 로그인 여부 확인
  def authenticate_user!
    redirect_to login_path, alert: "Please log in first" unless logged_in?
  end

  private

  # 세션 유효기간 갱신 (Sliding Expiration)
  # 요청이 들어올 때마다 세션에 값을 써서(touch), Rails가 응답 헤더에 새로운 만료시간을 담은 쿠키를 내려주게 유도함
  def refresh_session_expiration
    session[:last_seen_at] = Time.current
  end

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
end
