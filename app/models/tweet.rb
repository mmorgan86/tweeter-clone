class Tweet < ApplicationRecord
  # asssociations
  belongs_to :user

  # validations
  validates :message, presence: true
  validates :message, length: { maximum: 200, too_long: 'Tweets are only 200 characters max'}
end
