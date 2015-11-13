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

  private

  def set_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:title, :artist, :duration)
  end
end
