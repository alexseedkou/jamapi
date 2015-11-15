class LyricsSetsController < ApplicationController
  before_action :set_lyrics_set, only: [:show, :update, :destroy]
  before_action :find_first_or_create, only: [:get_lyrics_sets, :create]

  # GET /posts
  # GET /posts.json
  def index
    if params[:song_id].present?
      @lyrics_sets = LyricsSet.where(:song_id => params[:song_id]).sortedByVotes
    else
      #should is for testing only
      @lyrics_sets = LyricsSet.all.sortedByVotes
    end
    #we never show the entire database of lyrics, this is just for testing
    render json: @lyrics_sets
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    #show the entire content
    render json: @lyrics_set, serializer: LyricsSetContentSerializer
  end

 # POST /lyrics_sets
  def create
    puts "====Creating lyrics"
    if @song.nil?
      render json: { error: "Invalid parameters" }, status: 422
    else
      @lyrics_set = LyricsSet.new(:times => params[:times], :lyrics => params[:lyrics],
        :song_id => @song.id, :user_id => params[:user_id])
      if @lyrics_set.save
        render json: @lyrics_set, status: :created, location: @lyrics_set
      else
        render json: @lyrics_set.errors, status: :unprocessable_entity
      end
    end
  end

  # GET server/get_lyrics_sets
  def get_lyrics_sets
    if @song.nil?
      render json: { error: "Invalid parameters" }, status: 422
    else
      render json: @song.lyrics_sets.sortedByVotes
    end
  end

  private
  def set_lyrics_set
    @lyrics_set = LyricsSet.find(params[:id])
  end

  def save_and_render
    if @lyrics_set.save
      render json: @lyrics_set, status: :created, location: @lyrics_set
    else
      render json: @lyrics_set.errors, status: :unprocessable_entity
    end
  end
end
