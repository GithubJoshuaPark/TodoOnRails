# ApplicationController
# 모든 컨트롤러가 상속받는 기본 컨트롤러
# 로그인 상태 관리용 메소드 정의

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def authenticate_user!
    redirect_to login_path, alert: "Please log in first" unless logged_in?
  end

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
end
