class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest
  before_create { self.display_name = self.firstname + " " + self.lastname }
  before_create { self.user_name = "user_" + (User.last.id + 1).to_s }
  before_create { self.currency = "gbp" }

  has_many :spaces, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :artworks, dependent: :destroy
  has_many :orders
  has_many :active_relationships, class_name:      "Relationship",
                                  foreign_key:     "follower_id",
                                  dependent:       :destroy
  has_many :passive_relationships, class_name:     "Relationship",
                                  foreign_key:     "followed_id",
                                  dependent:       :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :reviews


  validates :firstname, presence: true, length: { maximum: 60 }
  validates :lastname, presence: true, length: { maximum: 60 }
  validates :display_name, presence: true, length: { maximum: 60 }, allow_nil: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  validates :instagram,   length: { maximum: 60 }
  validates :facebook,    length: { maximum: 60 }
  validates :twitter,     length: { maximum: 60 }
  validates :website,     length: { maximum: 60 }
  validates :bio,         length: { maximum: 1000 }
  validates :currency,    length: { maximum: 3 },  presence: true
  validates :user_name,   length: { maximum: 60 }

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random Token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Activates an Account
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # Set the password reset attributes
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns( reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  end

  # Sends password reset email
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Returns true if a password reset has expired
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  def space_feed
    Space.where("user_id IN (?) OR user_id =?", following_ids, id)
  end

  def art_feed
    Artwork.where("user_id IN (?) OR user_id =?", following_ids, id)
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  private

    # converts email to all lower-case
    def downcase_email
      self.email = email.downcase
    end

    # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
