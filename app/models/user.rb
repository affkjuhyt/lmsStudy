class User < ApplicationRecord
  has_many :courses
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :first_name, presence: true,
                        length: { maximum: Settings.user.first_name.maximum },
                        format: { with: Settings.user.first_name.regex }
  validates :last_name, presence: true,
                        length: { maximum: Settings.user.last_name.maximum },
                        format: { with: Settings.user.first_name.regex }
  validates :email, presence: true,
                    format: { with: Settings.user.email.regex },
                    uniqueness: { case_sensitive: false }
end
