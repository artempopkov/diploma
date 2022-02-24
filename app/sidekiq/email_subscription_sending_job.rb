require 'sidekiq-scheduler'
class EmailSubscriptionSendingJob
  include Sidekiq::Job

  def perform(*args)
    
    TestMailer.welcome_email.deliver_now
  end
end
