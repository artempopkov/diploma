class Tag < ApplicationRecord
  has_many :email_subscriptions, as: :subscriptionable

  def self.articles(tags)
    Article.tagged_with(tags.map(&:name))
  end
end
