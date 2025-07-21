class User < ApplicationRecord
  has_secure_password

  before_save :downcase_email

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  MAX_LENGTH_NAME = 50
  MAX_LENGTH_EMAIL = 255
  MAX_AGE_YEARS = 100

  validates :name, presence: true, length: {maximum: MAX_LENGTH_NAME}
  validates :email, presence: true,
                  length: {maximum: MAX_LENGTH_EMAIL},
                  format: {with: VALID_EMAIL_REGEX},
                  uniqueness: {case_sensitive: false}
  validates :birthday, presence: true
  validate :birthday_within_range

  has_many :microposts, dependent: :destroy

  private

  def downcase_email
    email.downcase!
  end

  def birthday_within_range
    return unless birthday

    errors.add(:birthday, :future_date) if birthday > Date.current

    max_age_date = Date.current - MAX_AGE_YEARS.years

    return unless birthday < max_age_date

    errors.add(:birthday, :too_old, years: MAX_AGE_YEARS)
  end
end
