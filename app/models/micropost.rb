class Micropost < ApplicationRecord
  MAX_CONTENT_LENGTH = 140
  MAX_IMAGE_SIZE = 5.megabytes
  MEGABYTE_IN_BYTES = 1.megabyte.freeze
  MICROPOST_CREATE_PERMIT = %i(content image).freeze
  DISPLAY_IMAGE_SIZE = [500, 500].freeze

  belongs_to :user
  has_one_attached :image

  validates :content, presence: true, length: {maximum: MAX_CONTENT_LENGTH}
  validates :user_id, presence: true
  validates :image,
            content_type: {in: Settings.upload.image_content_types,
                           message: :format_invalid},
            size: {less_than: MAX_IMAGE_SIZE,
                   message: :too_large}

  scope :newest, -> {order(created_at: :desc)}
  scope :relate_post, ->(user_ids) {where user_id: user_ids}

  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: DISPLAY_IMAGE_SIZE
  end
end
