class SongsController < ApplicationController
  before_action :set_song, only: [:show, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @songs = Song.all
    render json: @songs
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    render json: @song
  end

  private

  def set_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:post).permit(:title, :artist, :album)
  end
end
