class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])

    if @user&.authenticate(params[:session][:password])
      log_in(@user)
      redirect_to root_url
    else
      flash.now[:alert] = "Email or password is invalid."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Successfully logged out!"
  end
end
