class SongSerializer < ActiveModel::Serializer
  attributes :id, :title, :artist, :duration, :total_score, :set_scores, :soundwave_url
  has_many :tabs_sets
  has_many :lyrics_sets
end
