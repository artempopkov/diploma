class NewsletterDate < ApplicationRecord
  validates :sent_at, presence: true

  enum schedule: {daily: 0, weekly: 1}

  scope :daily, -> { where(schedule: 0) }
end
