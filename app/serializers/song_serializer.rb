class SongSerializer < ActiveModel::Serializer
  attributes :id, :title, :artist, :duration
  has_many :tabs_sets
end
