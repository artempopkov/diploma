class EmailSubscription < ApplicationRecord
  belongs_to :subscriptionable, polymorphic: true, optional: true
  belongs_to :category, optional: true
  belongs_to :tag, optional: true
end
