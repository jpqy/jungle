class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates :password, length: { minimum: 8}

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email)
    if user.authenticate(password)
      return user;
    end
    return nil;
  end
end
