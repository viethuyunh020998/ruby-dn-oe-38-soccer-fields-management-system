class User < ApplicationRecord
  has_many :bookings, dependent: :destroy
  enum role: {user: 0, admin: 1}

  has_secure_password

  before_save :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  VALID_PHONE_REGEX = /\A\d[0-9]{9}\z/.freeze
  validates :name, presence: true,
            length: {maximum: Settings.model.user.name_max}

  validates :email, presence: true,
            length: {maximum: Settings.model.user.email_max},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: true}
  validates :phone, presence: true,
            format: {with: VALID_PHONE_REGEX}

  validates :password, presence: true,
            length: {minimum: Settings.model.user.password_mini},
            allow_nil: true

  def downcase_email
    email.downcase!
  end

  def self.digest string
    if cost = ActiveModel::SecurePassword.min_cost
      BCrypt::Engine::MIN_COST
    else
      BCrypt::Engine.cost
    end
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def authenticated? remember_token
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_column :remember_digest, nil
  end
end
