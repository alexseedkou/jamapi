class SongInformationSerializer < ActiveModel::Serializer
  attributes :id, :title, :artist, :duration, :total_score, :soundwave_url, :in_iTunes,
  :track_id, :album, :artwork_url
end
