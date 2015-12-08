class UserInitializationSerializer < ActiveModel::Serializer
  attributes :id, :email, :auth_token, :nickname, :avatar_url_medium, :avatar_url_thumbnail
end
