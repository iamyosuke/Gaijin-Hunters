class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :profile, dependent: :destroy
  after_create :create_profile
  has_many :swipes
  has_many :swiped_users, through: :swipes, source: :swiped_user
  has_many :received_swipes, class_name: 'Swipe', foreign_key: 'swiped_user_id'

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         def ensure_profile
          create_profile if profile.nil?
        end

        private

        def create_profile
          build_profile.save
        end
end
