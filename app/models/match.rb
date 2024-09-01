class Match < ApplicationRecord
  belongs_to :user
  belongs_to :matched_user, class_name: 'User'

  validates :user_id, uniqueness: { scope: :matched_user_id }
  validate :user_cannot_match_self

  private

  def user_cannot_match_self
    errors.add(:base, "ユーザーは自分自身とマッチングできません") if user_id == matched_user_id
  end
end
