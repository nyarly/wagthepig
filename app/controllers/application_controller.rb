class ApplicationController < ActionController::Base
  before_action :route_vars

  private

  def route_vars
    @controller = params[:controller]
    @action = params[:action]
  end
end
