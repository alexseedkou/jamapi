class TabsSetSerializer < ActiveModel::Serializer
  attributes :id, :tuning, :capo, :song_id, :upvotes, :downvotes
end
