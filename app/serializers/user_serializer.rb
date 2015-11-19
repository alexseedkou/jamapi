class UserSerializer < ActiveModel::Serializer
  attributes :id, :email 
  has_many :tabs_sets
  has_many :lyrics_sets
end
