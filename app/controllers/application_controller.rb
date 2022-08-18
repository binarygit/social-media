class ApplicationController < ActionController::Base
  before_action :require_login
  include SessionsHelper

  private

  def require_login
    unless logged_in?
      flash.alert = "You must login first"
      redirect_to login_url
    end
  end
end
