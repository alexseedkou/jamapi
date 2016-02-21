class TabsSetsController < ApplicationController
  before_action :set_tabs_set, only: [:show, :update, :destroy]
  before_action :find_first_or_create, only: [:get_tabs_sets, :create , :get_most_liked_tabs_set]
  # we don't need user to index and show, but we need user to create,
  # and the matched user to update and delete

  # GET /tabs_sets body: { "song_id": 1 }
  def index
    if params[:song_id].present?
      @tabs_sets = TabsSet.where(:song_id => params[:song_id]).visible.sortedByVotes
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

  # GET /tabs_sets/:id
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
      @set = TabsSet.where(song_id: @song.id, user_id: params[:user_id]).first
      qualified = params[:times].count > 30 && params[:times].last.to_f > @song.duration / 2
      if @set.present?
        @set.update_attributes(:tuning => params[:tuning], :capo => params[:capo],
         :times => params[:times], :chords => params[:chords], :tabs => params[:tabs], :last_edited => Time.now,
         :visible => params[:visible], :qualified => qualified)
         aggregate_score
         render json: @set
      else
        @set = TabsSet.new(:tuning => params[:tuning], :capo => params[:capo],
         :times => params[:times], :chords => params[:chords], :tabs => params[:tabs],
          :song_id => @song.id, :user_id => params[:user_id], :last_edited => Time.now,
          :visible => params[:visible], :qualified => qualified)
        if @set.save
          set_first_tabs_added_date
          aggregate_score
          render json: @set, status: :created, location: @set
        else
          render json: @set.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE tabs_sets/:id
  def destroy
    @tabs_set.destroy
    if @tabs_set.destroyed?
      render json: { result: "successfully destroyed"}
    else
      render json: { result: "cannot destroy"}
    end
  end

  # GET server/get_most_liked_tabs_set
  def get_most_liked_tabs_set
    if @song.nil?
        render json: { error: "Invalid parameters" }, status: 422
    else
      most_liked_set = @song.tabs_sets.visible.sortedByVotes.first
      if most_liked_set.present?
          render json: @song.tabs_sets.visible.sortedByVotes.first, serializer: TabsSetContentSerializer
      else
          render json: { error: "not-found"}, status: 404
      end
    end
  end

  # GET server/get_tabs_sets
  def get_tabs_sets
    if @song.nil?
      render json: { error: "Invalid parameters" }, status: 422
    else
      if params[:user_id].present? #return vote status along with all tabsSets
        render json: @song.tabs_sets.visible.sortedByVotes, :user => User.find(params[:user_id])
      else
        render json: @song.tabs_sets.visible.sortedByVotes
      end
    end
  end

 #PUT /tabs_sets/:id/change_visibility
  def change_visibility
    set = TabsSet.find(params[:id])
    if set.visible
      set.visible = false
    else
      set.visible = true
    end
    set.save
    render json: set
  end

  #PUT /tabs_sets/:id/like  body: { "user_id": id}
  def upvote
    @set = TabsSet.find(params[:id])
    current_user = User.find(params[:user_id])
    if current_user.voted_up_on? @set #if this user already voted, remove the vote
      @set.unliked_by current_user
    else
      @set.upvote_by current_user
    end
    aggregate_score
    render json: @set, :user => current_user
  end

  #PUT /tabs_sets/:id/dislike  body: { "user_id": id}
  def downvote
    @set = TabsSet.find(params[:id])
    current_user = User.find(params[:user_id])
    if current_user.voted_down_on? @set #if this user already voted, remove the vote
      @set.undisliked_by current_user
    else
      @set.downvote_by current_user
    end
    aggregate_score
    render json: @set, :user => current_user
  end

  private
  def aggregate_score
    song = @set.song
    total_score = 0
    song.tabs_sets.each do |t|
      if t.qualified && t.visible
        total_score += 2 + t.cached_votes_score
      end
    end
    song.update_attributes(:total_score => total_score)
  end

  #when first good tabs is submitted, we list the song as New Song
  def set_first_tabs_added_date
    if @set.visible && @set.qualified && @song.tabs_sets.count == 1 && @song.in_iTunes
      @song.update_attributes(:first_tabs_added_at => @set.created_at)
    end
  end

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
