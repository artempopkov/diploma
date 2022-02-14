class User < ApplicationRecord
  devise :database_authenticatable, :recoverable, :registerable, :rememberable, :validatable
  validates :name, presence: true, length: { maximum: 20 }

  acts_as_voter
  has_many :comments, dependent: :destroy
  has_many :views, class_name: "Impression", foreign_key: "user_id", dependent: :nullify

  def viewed_articles
    viewed_articles_ids = views.pluck(:impressionable_id).uniq

    articles = viewed_articles_ids.each_with_object([])do |id, articles|
      articles << Article.where(id: id)
    end
  end
end
