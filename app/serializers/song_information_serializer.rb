class SongInformationSerializer < ActiveModel::Serializer
  attributes :id, :title, :artist, :duration
end
