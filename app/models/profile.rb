class Profile < ApplicationRecord
  belongs_to :user

  validates :bio, length: { maximum: 500 }
  validates :gender, inclusion: { in: ['male', 'female', 'other'] }, allow_blank: true

  before_save :remove_blank_attributes

  private

  def remove_blank_attributes
    attributes.each do |key, value|
      self[key] = nil if value.blank?
    end
  end
end
