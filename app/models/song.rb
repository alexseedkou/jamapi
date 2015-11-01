class Song < ActiveRecord::Base
  has_many :tabs_sets
  has_many :lyrics_sets
end
