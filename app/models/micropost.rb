class Micropost < ApplicationRecord
  MAX_CONTENT_LENGTH = 140

  belongs_to :user

  validates :content, presence: true, length: {maximum: MAX_CONTENT_LENGTH}
  validates :user_id, presence: true

  scope :recent, ->{order(created_at: :desc)}
end
