class LyricsSetSerializer < ActiveModel::Serializer
  attributes :id, :upvotes, :downvotes, :song_id, :user_id, :number_of_lines, :lyrics_preview
end
