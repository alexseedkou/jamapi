class SongsController < ApplicationController
  before_action :set_song, only: [:show, :update, :destroy]

  # GET server/findsongorcreate
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
      render json: @song
    else
      render json: { error: "Parameters are not valid" }, status: 422
    end
  end

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

  private

  def set_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:title, :artist, :duration)
  end
end
