class UserListSerializer < ActiveModel::Serializer
  attributes :id, :nickname, :avatar_url_medium, :avatar_url_thumbnail
end
