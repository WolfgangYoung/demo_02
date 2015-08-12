class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL = /([\w+.]+)@[a-z0-9\-.]+\.[a-zA-Z]+/
  validates :email, presence: true, length:{ maximum: 255 },
                    format: { with: VALID_EMAIL },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { maximum: 6 }
  has_secure_password
end
