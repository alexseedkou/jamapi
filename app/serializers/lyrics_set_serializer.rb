class LyricsSetSerializer < ActiveModel::Serializer
  attributes :id, :upvotes, :downvotes, :song_id, :user_id
end
