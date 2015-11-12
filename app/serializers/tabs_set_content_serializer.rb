class TabsSetContentSerializer < ActiveModel::Serializer
  attributes :id, :tuning, :capo, :song_id, :upvotes, :downvotes, :times, :chords, :tabs
end
