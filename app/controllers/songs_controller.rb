class SongsController < ApplicationController
  before_action :set_song, only: [:show, :destroy]

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

  # POST /songs
  def create
    find_first_or_create
    render json: @song, serializer: SongInformationSerializer
  end

  # PUT /:id  body:  body: {title: "", artist: "", duration: "", soundwave_url: ""}
  def update
    find_first_or_create
    if params[:soundwave_url].present?
      @song.update_attributes(:soundwave_url, params[:soundwave_url])
      render json: @song, serializer: SongInformationSerializer
    end
  end

  # GET /get_top_songs, no parameter
  def get_top_songs
    render json: Song.order(:total_score).reverse.select{ |song| song.total_score > 1 },
     each_serializer: SongInformationSerializer
  end

  # GET /get_soundwave_url
  def get_soundwave_url
    find_first_or_create
    render json: @song, serializer: SongInformationSerializer
  end

  # we used a GET method to save, not sure this is the best option but it is simple
  # GET /update_soundwave_url  body:  body: {title: "", artist: "", duration: "", soundwave_url: ""}
  def update_soundwave_url
    find_first_or_create
    if params[:soundwave_url].present?
      @song.update_attributes(:soundwave_url => params[:soundwave_url])
      render json: @song, serializer: SongInformationSerializer
    end
  end

  private
  def set_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:title, :artist, :duration)
  end
end
