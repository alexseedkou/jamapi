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
    render json: Song.order(:total_score).reverse.select{ |song| song.total_score > 0 },
     each_serializer: SongInformationSerializer
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
