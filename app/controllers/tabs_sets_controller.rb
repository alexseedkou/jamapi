class TabsSetsController < ApplicationController
  before_action :set_tabs_set, only: [:show, :update, :destroy]

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
    render json: @tabs_set
  end

  # POST /posts
  # POST /posts.json

  #this is always called after checking if a song exists,
  #if it doesn't, it creates a new one and return a song_id
  def create
    @tabs_set = TabsSet.new(tabs_sets_params)
    if @tabs_set.save
      render json: @tabs_set, status: :created, location: @tabs_set
    else
      render json: @tabs_set.errors, status: :unprocessable_entity
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
