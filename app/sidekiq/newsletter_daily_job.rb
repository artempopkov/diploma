require "sidekiq-scheduler"

class NewsletterDailyJob
  include Sidekiq::Job

  def perform(*args)
    EmailSubscription.transaction do
      articles = Hash.new([])

      EmailSubscription.find_each(batch_size: 100) do |sub|
        model = sub.subscriptionable_type.constantize
        find_by_instances = model.where(id: sub.subscriptionable_ids)
        found_articles = model.articles(find_by_instances).published.where("published_at > ?", NewsletterDate.daily.last.sent_at)
        articles[sub.user.email] += found_articles if found_articles.present?
      end

      articles = remove_duplicates(articles)
      articles.each do |email, article|
        NewsletterDate.create!(sent_at: Time.zone.now)
        NewsletterMailer.with(articles: article.sample(5), email: email).newsletter_email.deliver_later
      end
    end
  end

  private

  def remove_duplicates(articles)
    articles.transform_values! { |v| v.uniq }
  end
end
