require "sidekiq-scheduler"

class EmailSubscriptionSendingJob
  include Sidekiq::Job

  def perform(*args)
    articles = []
    
    EmailSubscription.find_each(batch_size: 100) do |sub|
      model = sub.subscriptionable_type.constantize
      find_by_instance = model.where(id: sub.subscriptionable_ids)
      articles += model.articles(find_by_instance).published
    end

    TestMailer.with(articles: articles).welcome_email.deliver_now
  end
end
