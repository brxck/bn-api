class User < ApplicationRecord
  has_secure_password
  has_secure_token

  validates :email, presence: true, uniqueness: true

  has_many :notes

  def invalidate_token
    update_columns(token: nil)
  end

  def self.valid_login(email, password)
    user = find_by(email: email)
    user if user&.authenticate(password)
  end
end
