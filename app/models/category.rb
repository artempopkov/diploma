class Category < ApplicationRecord
  has_many :articles
  validates :name, presence: true, uniqueness: true
  has_many :email_subscriptions, as: :subscriptionable
end
