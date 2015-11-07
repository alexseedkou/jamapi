class Song < ActiveRecord::Base
  searchkick
  has_many :tabs_sets
  has_many :lyrics_sets
end
