class TabsSetsController < ApplicationController
  before_action :set_tabs_set, only: [:show, :update, :destroy]
  before_action :find_first_or_create, only: [:get_tabs_sets, :create , :get_most_liked_tabs_set]
  # we don't need user to index and show, but we need user to create,
  # and the matched user to update and delete

  # GET /tabs_sets
  def index
    if params[:song_id].present?
      @tabs_sets = TabsSet.where(:song_id => params[:song_id]).sortedByVotes
    else
      #should is for testing only
      @tabs_sets = TabsSet.all.sortedByVotes
    end
    #we never show the entire database of tabs, this is just for testing
    if params[:user_id].present?
      render json: @tabs_sets, :user => User.find(params[:user_id])
    else
      render json: @tabs_sets
    end
  end

  # GET /tabs_sets/1
  def show
    #show times, chords, and tabs of the particular tabsSet
    render json: @tabs_set, serializer: TabsSetContentSerializer
  end

  # POST /tabs_sets

  # find_first_or_create is called to find song_id before create
  def create
    if @song.nil?
      render json: { error: "Invalid parameters" }, status: 422
    else
      # we only allow one tabsSet per song for one user
      # so if we found one already, we just update it
      found_tabs_set = TabsSet.where(song_id: @song.id, user_id: params[:user_id]).first
      if found_tabs_set.present?
        found_tabs_set.update_attributes(:tuning => params[:tuning], :capo => params[:capo],
         :times => params[:times], :chords => params[:chords], :tabs => params[:tabs])
         render json: found_tabs_set
      else
        tabs_set = TabsSet.new(:tuning => params[:tuning], :capo => params[:capo],
         :times => params[:times], :chords => params[:chords], :tabs => params[:tabs],
          :song_id => @song.id, :user_id => params[:user_id])
        if tabs_set.save
          render json: tabs_set, status: :created, location: tabs_set
        else
          render json: tabs_set.errors, status: :unprocessable_entity
        end
      end
    end
  end


  # GET server/get_most_liked_tabs_set
  def get_most_liked_tabs_set
    if @song.nil?
        render json: { error: "Invalid parameters" }, status: 422
    else
      render json: @song.tabs_sets.sortedByVotes.first
    end
  end

  # GET server/get_tabs_sets
  def get_tabs_sets
    if @song.nil?
      render json: { error: "Invalid parameters" }, status: 422
    else
      if params[:user_id].present?
        render json: @song.tabs_sets.sortedByVotes, :user => User.find(params[:user_id])
      else
        render json: @song.tabs_sets.sortedByVotes
      end
    end
  end

  #PUT /tabs_sets/:id/like  body: { "user_id": id}
  def upvote
    set = TabsSet.find(params[:id])
    current_user = User.find(params[:user_id])
    if current_user.voted_up_on? set #if this user already voted, remove the vote
      set.unliked_by current_user
    else
      set.upvote_by current_user
    end
    render json: set, :user => current_user
  end

  #PUT /tabs_sets/:id/dislike  body: { "user_id": id}
  def downvote
    set = TabsSet.find(params[:id])
    current_user = User.find(params[:user_id])
    if current_user.voted_down_on? set #if this user already voted, remove the vote
      set.undisliked_by current_user
    else
      set.downvote_by current_user
    end
    render json: set, :user => current_user
  end

  private
  def set_tabs_set
    @tabs_set = TabsSet.find(params[:id])
  end

  def save_and_render
    if @tabs_set.save
      render json: @tabs_set, status: :created, location: @tabs_set
    else
      render json: @tabs_set.errors, status: :unprocessable_entity
    end
  end

end
