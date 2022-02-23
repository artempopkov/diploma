class Tag < ApplicationRecord
  has_many :email_subscriptions, as: :subscriptionable
end
