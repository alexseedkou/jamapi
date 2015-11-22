class LyricsSetSerializer < ActiveModel::Serializer
  attributes :id, :cached_votes_score, :song_id, :user_id, :number_of_lines, :lyrics_preview
end
