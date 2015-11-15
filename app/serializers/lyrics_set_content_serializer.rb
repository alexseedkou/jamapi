class LyricsSetContentSerializer < ActiveModel::Serializer
  attributes :id, :upvotes, :downvotes, :times, :lyrics, :song_id, :user_id
end
