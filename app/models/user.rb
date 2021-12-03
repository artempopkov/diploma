class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :registerable, :rememberable, :validatable
  self.per_page = 2
end
