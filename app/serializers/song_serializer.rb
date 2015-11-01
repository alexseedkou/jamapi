class SongSerializer < ActiveModel::Serializer
  attributes :id, :title, :artist, :album
  has_many :tabs_sets
end
