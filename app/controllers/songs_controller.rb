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

  # POST /songs
  def create
    find_first_or_create
    render json: @song, serializer: SongInformationSerializer
  end

  # PUT /:id   body: {soundwave_url: ""}
  def update
    if params[:soundwave_url].present?
      @song.update_attributes(:soundwave_url => params[:soundwave_url])
      render json: @song, serializer: SongInformationSerializer
    end
  end

  # GET /get_top_songs, no parameter
  def get_top_songs
    render json: Song.order(total_score: :desc).where('total_score > 1 AND track_id > 10').limit(100),
     each_serializer: SongInformationSerializer
  end

  # GET /get_new_songs
  def get_new_songs #new songs with tabs
    render json: Song.joins(:tabs_sets).where('tabs_sets.qualified' => true, 'tabs_sets.visible' => true)
    .order('tabs_sets.updated_at DESC')
  end

  # GET /get_soundwave_url
  def get_soundwave_url
    find_first_or_create
    render json: @song, serializer: SongInformationSerializer
  end

  private
  def set_song
    @song = Song.find(params[:id])
  end
end
