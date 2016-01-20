class UserMailer < ApplicationMailer
  default from: 'song@twistjam.com'
  layout 'mailer'
  def password_reset(user)
    @user = user
    @url  = 'http://example.com/reset'
    mail(to: @user.email, subject: 'Password Reset')
  end
end
