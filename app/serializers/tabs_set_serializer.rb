class TabsSetSerializer < ActiveModel::Serializer
  attributes :id, :tuning, :capo, :times, :chords, :tabs, :song_id
  #has_one :song, include: false
end
