class HomeController < ApplicationController
  layout false

  def index
    if signin?
      redirect_to_home_page(@current_user)
    else
      redirect_to signin_path
    end
  end

  def welcome
  end
end
