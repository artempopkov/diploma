class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :registerable, :rememberable, :validatable
  validates :name, presence: true, length: { maximum: 20 }
  
  acts_as_voter
  has_many :comments, dependent: :destroy
  has_many :impressions, class_name: 'Impression', foreign_key: 'user_id', dependent: :nullify
end
