class SongSerializer < ActiveModel::Serializer
  attributes :id, :title, :artist, :duration
  has_many :tabs_sets
  has_many :lyrics_sets
end
