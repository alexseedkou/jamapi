class PasswordResetsController < WebBaseController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      user.send_password_reset
      render json: { message: "Email sent with password reset instructions"}
    else
      render json: { message: "Cannot find this user with email #{params[:email]}"}
    end
  end

  def edit
    @user = User.where(password_reset_token: params[:token]).first
  end

  def update
    @user = User.where(password_reset_token: params[:id]).first!
    if @user.password_reset_sent_at < 2.hours.ago
      @message = "This link has expired."
    elsif @user.update_password(update_params)
      @message = "Your password has been reset."
    end
  end

  def update_params
    params.require(:user).permit(:password)
  end

end
