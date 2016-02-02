class SongInformationSerializer < ActiveModel::Serializer
  attributes :id, :title, :artist, :duration, :total_score, :set_scores, :soundwave_url, :in_iTunes,
  :track_id, :album, :artwork_url, :preview_url, :store_link, :title_aliases, :artist_aliases
end
