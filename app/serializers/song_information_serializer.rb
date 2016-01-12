class SongInformationSerializer < ActiveModel::Serializer
  attributes :id, :title, :artist, :duration, :total_score
end
