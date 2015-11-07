class SongsController < ApplicationController
  before_action :set_song, only: [:show, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    # do search later
    # if params[:query].present?
    #   @songs = Song.search(params[:query])
      #TODO: this is very bad to initialize the database, needs a better way, what if capital case
    if params[:title].present? && params[:artist].present? && params[:album].present?
      @songs = Song.where("title LIKE ? AND artist LIKE ? AND album LIKE ?",
      params[:title], params[:artist], params[:album])
      if @songs.size == 0 #song not in database yet
        puts "no song found"
        #then initialize this song
        newSong = Song.new(title: params[:title], artist: params[:artist], album: params[:album])
        if newSong.save
          puts "new song created with and ID #{newSong.id}"
        end
      end
    else
      @songs = Song.all
    end
    render json: @songs
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
    params.require(:song).permit(:title, :artist, :album, :times, :chords, :tabs, :song_id)
  end
end
