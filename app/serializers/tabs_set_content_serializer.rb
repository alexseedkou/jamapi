class TabsSetContentSerializer < ActiveModel::Serializer
  attributes :id, :tuning, :capo, :upvotes, :downvotes, :times, :chords, :tabs, :song_id, :user_id
end
