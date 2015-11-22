class TabsSetSerializer < ActiveModel::Serializer
  attributes :id, :tuning, :capo, :cached_votes_score, :song_id, :user_id, :chords_preview
end
