class Moderator < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable
  self.per_page = 10
end
