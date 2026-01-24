class PagesController < ApplicationController
  # intro, about 페이지는 로그인하지 않은 사용자도 접근 가능하도록 설정
  skip_before_action :authenticate_user!, only: [ :intro, :about ]

  # intro 페이지
  def intro
    redirect_to todos_path if logged_in?
  end

  # about 페이지
  def about
  end
end
