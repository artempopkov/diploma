class Category < ApplicationRecord
  has_many :article
  validates :name, presence: true, uniqueness: true
end
