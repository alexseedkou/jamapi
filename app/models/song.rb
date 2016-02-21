
class Song < ActiveRecord::Base
  #searchkick
  has_many :tabs_sets, -> { order("created_at DESC") }
  has_many :lyrics_sets

  acts_as_votable #as favorites for user
end
