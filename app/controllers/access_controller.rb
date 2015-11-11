class AccessController < ApplicationController

  # GET /access/validate_email?email=example@email.com
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

 # GET /access/validate_username?username=example
  def validate_username
    if params[:username].present?
      u = User.new
      u.username = params[:username]
      u.email = "forvalidation@email.com"
      u.password = "forvalidation"
      if u.validate
        render json: { valid: "username is valid"}
      else
        render json: { erorr: u.errors.full_messages }
      end
    end
  end

  # isn't this a POST?
  # GET /access/sign_up?username=example&email=example@email.com&password=yourpassword
  def sign_up
    if params[:email].present? && params[:username].present? && params[:password].present?
      newUser = User.new(:email => params[:email], :username => params[:username], :password => params[:password])
      if newUser.save
        render json: { token: newUser.auth_token }
      else
        render json: { error: newUser.errors.full_messages }
      end
    end
  end

  # GET /access/attempt_login
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
end
