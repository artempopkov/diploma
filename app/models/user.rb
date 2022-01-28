class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :registerable, :rememberable, :validatable
  acts_as_voter
  has_many :comments, dependent: :destroy
end
