class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar
  validates :bio, length: { maximum: 500 }
  validates :gender, inclusion: { in: ['male', 'female', 'other'] }, allow_blank: true
  validate :acceptable_avatar
  before_save :remove_blank_attributes

  private

  def acceptable_avatar
    return unless avatar.attached?

    unless avatar.blob.byte_size <= 1.megabyte
      errors.add(:avatar, "は1MB以下である必要があります")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(avatar.content_type)
      errors.add(:avatar, "はJPEGまたはPNG形式である必要があります")
    end
  end

  def remove_blank_attributes
    attributes.each do |key, value|
      self[key] = nil if value.blank?
    end
  end
end
