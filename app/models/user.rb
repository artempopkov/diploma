class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :registerable, :rememberable, :validatable
  validates :name, presence: true, length: { maximum: 20 }
  after_create :create_email_subscription

  acts_as_voter
  has_many :comments, dependent: :destroy
  has_many :views, class_name: "Impression", foreign_key: "user_id", dependent: :nullify
  has_many :email_subscriptions, dependent: :destroy

  private

  def create_email_subscription
    EmailSubscription.create(user_id: id, subscriptionable_type: "Category")
    EmailSubscription.create(user_id: id, subscriptionable_type: "Tag")
  end
end
