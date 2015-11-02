class TabsSetSerializer < ActiveModel::Serializer
  attributes :id, :tuning, :capo, :times, :chords, :tabs
  #has_one :song, include: false
end
