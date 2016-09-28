class User < ApplicationRecord

  attr_accessor :remember_token

  before_save { email.downcase! } #this syntax works because in User class
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password # doesn't prevent blank password
  # presence: true prevents blank password
  # allow_nil allows empty password updates...meh feature
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def remember
    # self uses attr_accessor method
    self.remember_token = User.new_token
    # modify the database
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(unverified_remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest) == unverified_remember_token
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end

def User.digest(string)
  cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
  BCrypt::Password.create(string, cost: cost)
end

def User.new_token
  SecureRandom.urlsafe_base64
end
