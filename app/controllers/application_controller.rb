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

  #private
    #used in tabs_sets_controller and lyrics_sets_controller to find the song, if not found, create the song
    #must create a song object no matter what
    def find_first_or_create
      unless params[:title].nil? && params[:artist].nil? && params[:duration].nil?
        title = params[:title]
        artist = params[:artist]
        duration = params[:duration]
        #this matched all the songs we have matched with the one in iTunes
        matchedSong = Song.where('LOWER(title_aliases) LIKE ? AND LOWER(artist_aliases) LIKE ? AND ( duration BETWEEN ? AND ? )',
         '%' + title.downcase + '%', '%' + artist.downcase + '%', duration.to_f - 2, duration.to_f + 2).first

        unless matchedSong.nil?
          @song = matchedSong
        else #if not yet found
          find_song_in_iTunes(title, artist, duration)
        end
      end
    end

    # We want to find the matched song in iTunes and store the iTunes song's information
    # in our database
    def find_song_in_iTunes(title, artist, duration)
      #for testing purpose
      if duration == nil || title == nil || artist == nil
        return
      end

      #result = JSON.parse(open("https://itunes.apple.com/search?limit=10&media=music&term=#{@song.title } #{@song.artist}").read)
      uri = "https://itunes.apple.com/search?limit=10&media=music&term=#{title} #{artist}"
      uri = uri.gsub!(" ", "%20")
      jsonResult = JSON.parse(HTTP.get(uri).to_s)
      jsonResult["results"].each do |result|
        r_id = result["trackId"]
        r_title = result['trackName']
        r_artist = result['artistName']
        r_album = result['collectionName']
        r_artwork = result['artworkUrl100']
        r_duration = (result["trackTimeMillis"].to_f)/1000
        r_preview = result['previewUrl']
        r_store_link = result['trackViewUrl']

        if (r_duration - duration.to_f).abs <= 2
          #for reinitialize database
          # alreadyAdded = Song.where('LOWER(title) = ? AND LOWER(artist) = ? AND ( duration BETWEEN ? AND ? )',
          # title.downcase, artist.downcase, duration.to_f - 2 , duration.to_f + 2).first
          alreadyAdded = Song.where(track_id: r_id).first
          unless alreadyAdded.nil?
            #if the aliases do not contain the terms yet, we add the new aliases
            unless alreadyAdded.title_aliases.downcase.include? title.downcase
              alreadyAdded.update_attributes(:title_aliases => alreadyAdded.title_aliases += title)
            end
            unless alreadyAdded.artist_aliases.downcase.include? artist.downcase
              alreadyAdded.update_attributes(:artist_aliases => alreadyAdded.artist_aliases += artist)
            end
            @song = alreadyAdded

            #for reinitialize all the database
          #   title_alias = (r_title.downcase.include? title.downcase) ? r_title : r_title + title
          #   artist_alias = (r_artist.downcase.include? artist.downcase) ? r_artist : r_artist + artist
          #   @song.update_attributes(title: r_title, artist: r_artist, duration: r_duration, in_iTunes: true,
          #   :title_aliases => title_alias, :artist_aliases => artist_alias, track_id: r_id, album: r_album, artwork_url: r_artwork)
           else # this song has never been added before
            title_alias = (r_title.downcase.include? title.downcase) ? r_title : r_title + title
            artist_alias = (r_artist.downcase.include? artist.downcase) ? r_artist : r_artist + artist
            @song = Song.create(title: r_title, artist: r_artist, duration: r_duration, in_iTunes: true,
            title_aliases: title_alias, artist_aliases: artist_alias, track_id: r_id, album: r_album,
             artwork_url: r_artwork, preview_url: r_preview, store_link: r_store_link)
          end
          return
        end
      end#end of loop
      #if we cannot locate this song in iTunes library, we create a new one
      @song = Song.create(title: title, artist: artist, duration: duration.to_f, title_aliases: title, artist_aliases: artist)
    end
end
