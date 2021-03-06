class UsersController < ApplicationController

  before_action :set_user, only: [:show, :update, :favorite_a_song, :favorite_songs, :destroy]

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

    if params[:email].present? && params[:password].present? && params[:nickname].present?
      newUser = User.new(nickname: params[:nickname], email: params[:email], password: params[:password])
      if newUser.save
        render json: newUser , serializer: UserInitializationSerializer
      else
        render json: { error: newUser.errors.full_messages }
      end
    else
      render json: { error: "Invalid parameters" }, status: 422
    end
  end

  #update nickname, avatar urls
  def update
    #user is already logged in here
    #TODO: authenticate with token?
    if params[:nickname].present?
      @user.update_attribute(:nickname, params[:nickname])
    end

    if params[:avatar_url_medium].present? && params[:avatar_url_thumbnail].present?
      @user.update_attribute(:avatar_url_medium, params[:avatar_url_medium])
      @user.update_attribute(:avatar_url_thumbnail, params[:avatar_url_thumbnail])
    end
    render json: @user
  end

  def destroy
  end

  def attempt_login
    found_user = User.where(:email => params[:email]).first
    if found_user
      authorized_user = found_user.authenticate(params[:password])
      if authorized_user
        #this token is stored in iOS app, and is used to retrieve user profile
        render json: authorized_user, serializer: UserInitializationSerializer
      else
        render json: { error: "Invalid email/password" }, status: 401
      end
    elsif params[:attempt_login] == "facebook"
      #if this is an facebook login request and no yet user is found, we create a new one
      newUser = User.new(email: params[:email], password: params[:password], nickname: params[:nickname],
      avatar_url_thumbnail: params[:avatar_url_thumbnail],
      avatar_url_medium: params[:avatar_url_medium])
      if newUser.save
        render json: newUser , serializer: UserInitializationSerializer
      else
        render json: { error: newUser.errors.full_messages }
      end
    else
      render json: { error: "No users found" }, status: 401
    end
  end

  # GET /validate_email?email=example@email.com
  def validate_email
    if params[:email].present?
      u = User.new
      u.email = params[:email]
      u.nickname = "forvalidation"
      u.password = "forvalidation"
      if u.validate
        render json: { valid: "email is valid"}
      else
        render json: { error: u.errors.full_messages }
      end
    end
  end

  #PUT user/:id/favorite_a_song body: {"title":"", "artist": "", "duration": ""}
  def favorite_a_song
    find_first_or_create
    #if already voted, dislikes it
    if @user.voted_up_on? @song
      @user.dislikes @song
      render json: { result: "disliked"}
    else
      @user.likes @song
      render json: { result: "liked"}
    end
  end

  #GET user/:id/favorite_songs
  def favorite_songs
    songs = @user.get_up_voted Song
    render json: songs, each_serializer: SongInformationSerializer
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :auth_token)
  end

end
