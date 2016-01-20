class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset
      render json: { "messsage": "Email sent with password reset instructions"}
    else
      render json: { "message": "Cannot find this user with email #{params[:email]}"}
    end
  end

  def edit

  end

end
