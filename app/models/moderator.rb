class Moderator < ApplicationRecord
  include TranslateEnum
  devise :database_authenticatable, :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { maximum: 20 }
  
  has_many :articles
  has_many :reviews
  enum role: { correspondent: 0, editor: 1, admin: 2 }
  translate_enum :role

  after_initialize :assign_default_role, if: :new_record?

  private

  def assign_default_role
    self.role ||= :correspondent
  end
end
