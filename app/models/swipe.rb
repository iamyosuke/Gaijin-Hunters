class Swipe < ApplicationRecord
  belongs_to :user
  belongs_to :swiped_user, class_name: 'User'


  validates :direction, inclusion: { in: ['left', 'right'] }
  validates :user_id, uniqueness: { scope: :swiped_user_id, message: "has already swiped this user" }
  validate :cannot_swipe_self

  private

  def cannot_swipe_self
    errors.add(:base, "Cannot swipe yourself") if user_id == swiped_user_id
  end
end
