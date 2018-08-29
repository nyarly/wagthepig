class HomeController < ActionController::Base
  def index
    if user_signed_in?
      redirect_to events_path
      return
    end
  end
end
