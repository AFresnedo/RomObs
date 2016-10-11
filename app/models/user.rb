class User < ApplicationRecord
  # attributes: name, email, password_digest, remember_digest, admin,
  # created_at, updated_at, activation_digest, activated, activated_at
  attr_accessor :remember_token, :activation_token
  before_create :create_activation_token
  before_save :downcase_email
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  # presence: true prevents blank password, has_secure_password doesn't
  # allow_nil allows empty password updates...meh feature
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def remember
    # self uses attr_accessor method
    self.remember_token = User.new_token
    # modify the database
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest) == token
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      # urlsafe for account activation token
      SecureRandom.urlsafe_base64
    end
  end

  private

    def create_activation_token
      self.activation_token = User.new_token
      # update_attribute isn't necessary because not in db yet (before_create)
      self.activation_digest = User.digest(activation_token)
    end

    def downcase_email
      email.downcase!
    end
end
