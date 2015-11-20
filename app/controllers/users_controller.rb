class UsersController < ApplicationController

  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    render json: @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    render json: @user
  end

  # POST /users

  def create
    # attemp login in POST method to avoid exposing password in logs
    if params[:attempt_login].present?
      attempt_login
      return
    end

    if params[:email].present? && params[:password].present?
      newUser = User.new(:email => params[:email], :password => params[:password])
      if newUser.save
        render json: { user: newUser }
      else
        render json: { error: newUser.errors.full_messages }
      end
    else
      render json: { error: "Invalid parameters" }, status: 422
    end
  end

  def update
  end

  def destroy
  end

  def attempt_login
    found_user = User.where(:email => params[:email]).first
    if found_user
      authorized_user = found_user.authenticate(params[:password])
    end

    if authorized_user
      #this token is stored in iOS app, and is used to retrieve user profile
      render json: { user: authorized_user }
    else
      render json: { error: "Invalid username/password" }, status: 401
    end
  end

  # GET /validate_email?email=example@email.com
  def validate_email
    if params[:email].present?
      u = User.new
      u.email = params[:email]
      u.username = "forvalidation"
      u.password = "forvalidation"
      if u.validate
        render json: { valid: "email is valid"}
      else
        render json: { error: u.errors.full_messages }
      end
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :auth_token)
  end

end
