class User < ActiveRecord::Base
  acts_as_voter
  before_create -> { self.auth_token = SecureRandom.hex }
  has_secure_password
  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/i

  validates :password, :length => { :within => 6..50 }

  validates :email, :presence => true,
                    :length => { :maximum => 100 },
                    :format => EMAIL_REGEX,
                    :uniqueness => true

  has_many :tabs_sets
  has_many :lyrics_sets
end
