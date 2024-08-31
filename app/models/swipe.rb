class Swipe < ApplicationRecord
  belongs_to :user
  belongs_to :swiped_user, class_name: 'User'

  validates :user_id, uniqueness: { scope: :swiped_user_id }
  validates :direction, inclusion: { in: ['left', 'right'] }
end
