class TabsSetSerializer < ActiveModel::Serializer
  attributes :id, :tuning, :capo, :times, :chords, :tabs, :song_id, :upvotes, :downvotes
end
