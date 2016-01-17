class SongInformationSerializer < ActiveModel::Serializer
  attributes :id, :title, :artist, :duration, :total_score, :soundwave_url
end
