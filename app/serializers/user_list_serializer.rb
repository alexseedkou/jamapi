class UserListSerializer < ActiveModel::Serializer
  attributes :id, :email, :avatar_url_medium, :avatar_url_thumbnail
end
