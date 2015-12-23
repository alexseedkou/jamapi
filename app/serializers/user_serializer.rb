class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :nickname, :avatar_url_medium, :avatar_url_thumbnail
  has_many :tabs_sets, serializer: TabsSetContentSerializer
  has_many :lyrics_sets, serializer: LyricsSetContentSerializer
end
