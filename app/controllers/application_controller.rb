class ApplicationController < ActionController::API
  #example in command line
  #curl http://localhost:3000/songs -H 'Authorization: Token token=d002e15d331a6e1e35092ca191a4a
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_filter :authenticate_user_from_token, except: [:token]
  def token
   authenticate_with_http_basic do |email, password|
     user = User.find_by(email: email)
     if user && user.password == password
       render json: { token: user.auth_token }
     else
       render json: { error: 'Incorrect credentials' }, status: 401
     end#end of if
   end#end of do
 end#end of function

private
  def authenticate_user_from_token
    unless authenticate_with_http_token { |token, options| User.find_by(auth_token: token)}
      render json: { error: "Bad token"}, status: 401
    end
  end

end
