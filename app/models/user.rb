class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  attr_readonly :email

  has_many :notifications, foreign_key: :recipient_id
  has_many :user_courses, dependent: :destroy
  has_many :courses, through: :user_courses
  has_many :reviewed_courses, class_name: Course.class.name, through: :review_courses
  has_many :review_courses, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :exams, dependent: :destroy

  has_many :messages, dependent: :destroy
  has_many :send_conversations, class_name: "Conversation",
    foreign_key: :sender_id
  has_many :received_conversations, class_name: "Conversation",
    foreign_key: :recipient_id

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  scope :not_admin, -> { where(is_admin: false) }
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable , omniauth_providers: [:facebook, :google_oauth2]
  validates :first_name, presence: true,
                        length: { maximum: Settings.first_name.maximum }
  validates :last_name, presence: true,
                        length: { maximum: Settings.last_name.maximum }
  validates :email, presence: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  # Oauth
  def self.from_omniauth(auth)
    @user = find_by email: auth.info.email
    return @user if @user
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[8, 20]
      user.token = auth.credentials.token
      user.refresh_token = auth.credentials.refresh_token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save(validate: false)
    end
  end

  def conversations
    Conversation.where("sender_id = ? OR recipient_id = ?", self.id, self.id)
  end
end
