class TabsSetContentSerializer < ActiveModel::Serializer
  attributes :id, :cached_votes_score, :tuning, :capo, :times, :chords, :tabs,
  :song_id, :user_id, :chords_preview, :visible
  has_one :song, serializer: SongInformationSerializer
end
