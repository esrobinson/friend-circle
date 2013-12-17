class User < ActiveRecord::Base
  attr_accessible :email, :password

  attr_reader :password

  validates :email, :password_digest, :session_token, :presence => true

  validates :password, :presence => true,
                       :length => { :minimum => 6 },
                       :on => :create

  before_validation :reset_session_token, :on => :create

  has_many :friend_circle_memberships, :inverse_of => :user
  has_many :circles, :through => :friend_circle_memberships
  has_many :owned_circles, :class_name => "Circle"


  def self.find_by_credentials(email, password)
    user = self.find_by_email(email)
    if user && user.is_password?(password)
      user
    end
  end

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    reset_session_token
    self.save!
  end

  def password=(password)
    @password = password

    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def set_password_reset_token!
    self.password_reset_token = SecureRandom.urlsafe_base64
    self.save!
  end
end
