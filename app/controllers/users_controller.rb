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

    if params[:email].present? && params[:username].present? && params[:password].present?
      newUser = User.new(:email => params[:email], :username => params[:username], :password => params[:password])
      if newUser.save
        render json: { token: newUser.auth_token }
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
    #user can log in with either email or username
    if params[:email].present? && params[:password].present?
      found_user = User.where(:email => params[:email]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    elsif params[:username].present? && params[:password].present?
      found_user = User.where(:username => params[:username]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end
    if authorized_user
      #this token is stored in iOS app, and is used to retrieve user profile
      render json: { token: authorized_user.auth_token }
      puts "we are logged in and session username #{session[:username]}"
    else
      render json: { error: "Invalid username/password" }, status: 401
      puts "invalid username"
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
        render json: { erorr: u.errors.full_messages }
      end
    end
  end

 # GET /validate_username?username=example
  def validate_username
    if params[:username].present?
      u = User.new
      u.username = params[:username]
      u.email = "forvalidation@email.com"
      u.password = "forvalidation"
      if u.validate
        render json: { valid: "username is valid"}
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
