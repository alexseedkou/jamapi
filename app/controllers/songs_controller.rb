class SongsController < ApplicationController
  before_action :set_song, only: [:show, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    render json: Song.all
  end
  # GET /posts/1
  # GET /posts/1.json
  def show
    render json: @song
  end

  def create
    @song = Song.new(song_params)
    if @song.save
      render json: @song, status: :created, location: @song
    else
      render json: @song.errors, status: :unprocessable_entity
    end
  end

  # GET /get_top_songs, no parameter
  # currently sorted by all the scores of its tabs_sets in descending order
  def get_top_songs
    songs_scores = []
    Song.all.each do |song|
      #score = song.tabs_sets.map(&:cached_votes_score).sum
      sum = 0
      if song.tabs_sets.count == 0 then #if no tabs, just skip it
        next
      end
      song.tabs_sets.each do |set| #validate a good tabs, if times is not empty and must be bigger than 20
        unless set.times.nil?
          if set.times.count > 20
            sum += set.cached_votes_score
          end
          next
        end
      end

      if sum > 0 #if total score of all tabs is larger than 0, we add the song
        song_score = { song: song, score: sum }
        songs_scores.push(song_score)
      end
    end

    top_songs_dict = songs_scores.sort_by {|dic| dic[:score] }.reverse.first(100)
    top_songs = []
    top_songs_dict.each do |dic|
      top_songs.push(dic[:song])
    end
    render json: top_songs, each_serializer: SongInformationSerializer
  end



  # when a user clicks a song,
  # if no id stored, make an API to request an ID
  # return a song_id(whether newly created or existed)
  # store in device's database
  # must return and id
  # GET /get_song_id    body: {"title":"", "artist": "", "duration": 0.0 }
  def get_song_id
    find_first_or_create
    render json:  { song_id: @song.id }
  end

  private

  def set_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:title, :artist, :duration)
  end
end
