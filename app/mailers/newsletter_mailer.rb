class NewsletterMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def newsletter_email
    @articles = params[:articles]
    mail(to: 'test@example.com', subject: 'Newsletter')
  end
end
