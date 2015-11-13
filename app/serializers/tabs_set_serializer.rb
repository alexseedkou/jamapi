class TabsSetSerializer < ActiveModel::Serializer
  attributes :id, :tuning, :capo, :upvotes, :downvotes, :song_id, :user_id
end
