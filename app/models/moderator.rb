class Moderator < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable
  has_many :articles
  has_many :reviews
  enum role: { correspondent: 0, editor: 1, admin: 2 }

  after_initialize :assign_default_role, if: :new_record?

  private

  def assign_default_role
    self.role ||= :correspondent
  end
end
