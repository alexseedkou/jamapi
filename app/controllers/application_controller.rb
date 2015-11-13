class ApplicationController < ActionController::API

  #example in command line
  #curl http://localhost:3000/songs -H 'Authorization: Token token=46276600eaae312ff6e532d598cca7ec'
  # include ActionController::HttpAuthentication::Basic::ControllerMethods
  # include ActionController::HttpAuthentication::Token::ControllerMethods
  #before_filter :authenticate_user_from_token, except: [:token]
#
#   def token
#    authenticate_with_http_basic do |email, password|
#      user = User.find_by(email: email)
#      if user && user.password == password
#        render json: { token: user.auth_token }
#      else
#        render json: { error: 'Incorrect credentials' }, status: 401
#      end#end of if
#    end#end of do
#  end#end of function
#
# private
#   def authenticate_user_from_token
#     unless authenticate_with_http_token { |token, options| User.find_by(auth_token: token)}
#       render json: { error: "Bad token" }, status: 401
#     end
#   end
#
#  def confirm_logged_in
#       unless session[:user_id]
#         puts "Please login"
#         return false #halts the before_action
#       else
#         return true
#       end
#     end
  private
    #used in tabs_sets_controller and lyrics_sets_controller to find the song, if not found, create the song
    
    def find_first_or_create
      if params[:title].present? && params[:artist].present? && params[:duration].present?
        # check if we already have this song,
        # name, artist must exactly match and
        # the duration should be in one second range
        # of the one we have in database
        matchedSongs = Song.where("title = ? AND artist = ? AND ( duration BETWEEN ? AND ? )",
        params[:title], params[:artist], params[:duration].to_f - 1, params[:duration].to_f + 1)

        if matchedSongs.exists?
          @song = matchedSongs.first
        else
          @song = Song.create(title: params[:title], artist: params[:artist], duration: params[:duration].to_f)
        end
      end
    end
end
