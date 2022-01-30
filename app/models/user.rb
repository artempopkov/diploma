class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :registerable, :rememberable, :validatable
  acts_as_voter
  has_many :comments, dependent: :destroy
  has_many :impressions, class_name: 'Impression', foreign_key: 'user_id', dependent: :nullify
end
