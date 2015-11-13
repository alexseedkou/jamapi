class TabsSetsController < ApplicationController
  before_action :set_tabs_set, only: [:show, :update, :destroy]
  before_action :find_first_or_create, only: [:get_tabs_sets, :create]
  # we don't need user to index and show, but we need user to create,
  # and the matched user to update and delete

  # GET /posts
  # GET /posts.json
  def index
    if params[:song_id].present?
      @tabs_sets = TabsSet.where(:song_id => params[:song_id]).sortedByVotes
    else
      #should is for testing only
      @tabs_sets = TabsSet.all.sortedByVotes
    end
    #we never show the entire database of tabs, this is just for testing
    render json: @tabs_sets
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    #show times, chords, and tabs of the particular tabsSet
    render json: @tabs_set, serializer: TabsSetContentSerializer
  end

  # POST /posts
  # POST /posts.json

  # find_first_or_create is called to find song_id before create
  def create
    if @song.nil?
      render json: { error: "Invalid parameters" }, status: 422
    else
      @tabs_set = TabsSet.new(:tuning => params[:tuning], :capo => params[:capo],
       :times => params[:times], :chords => params[:chords], :tabs => params[:tabs], :song_id => @song.id)
      if @tabs_set.save
        render json: @tabs_set, status: :created, location: @tabs_set
      else
        render json: @tabs_set.errors, status: :unprocessable_entity
      end
    end
  end

  # GET server/get_tabs_sets
  def get_tabs_sets
    if @song.nil?

      render json: { error: "Invalid parameters" }, status: 422
    else
      render json: @song.tabs_sets
    end
  end

  private
  def set_tabs_set
    @tabs_set = TabsSet.find(params[:id])
  end

  def tabs_sets_params
    params.require(:tabs_set).permit(:tuning, :capo, :song_id, :times => [], :chords => [], :tabs=> [])
  end
end
