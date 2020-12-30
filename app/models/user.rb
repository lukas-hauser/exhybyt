class User < ApplicationRecord
  has_many :spaces, dependent: :destroy
  has_many :active_relationships, class_name:      "Relationship",
                                  foreign_key:     "follower_id",
                                  dependent:       :destroy
  has_many :passive_relationships, class_name:     "Relationship",
                                  foreign_key:     "followed_id",
                                  dependent:       :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  before_create { self.display_name = self.firstname + " " + self.lastname }
  before_save { self.email = email.downcase}
  validates :firstname, presence: true, length: { maximum: 60 }
  validates :lastname, presence: true, length: { maximum: 60 }
  validates :display_name, presence: true, length: { maximum: 60 }, allow_nil: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def feed
    Space.where("user_id IN (?) OR user_id =?", following_ids, id)
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

end
