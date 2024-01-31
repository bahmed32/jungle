class User < ApplicationRecord

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  
  def self.authenticate_with_credentials(email, password)
    user = find_by(email: email.downcase.strip)
    return user if user && user.authenticate(password)
  end
end