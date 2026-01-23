class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:intro, :about]

  def intro
    redirect_to todos_path if logged_in?
  end

  def about
  end
end
