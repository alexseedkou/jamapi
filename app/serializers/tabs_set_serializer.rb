class TabsSetSerializer < ActiveModel::Serializer
  attributes :id, :tuning, :capo, :times, :chords, :tabs
end
