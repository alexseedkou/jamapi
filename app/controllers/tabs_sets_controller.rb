class TabsSetsController < ApplicationController
  before_action :set_tabs_set, only: [:show, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @tabs_sets = TabsSet.all
    render json: @tabs_sets
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    render json: @tabs_set
  end

  private

  def set_tabs_set
    @tabs_set = TabsSet.find(params[:id])
  end

end
