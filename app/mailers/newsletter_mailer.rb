class NewsletterMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def newsletter_email
    @articles = params[:articles]
    mail(to: params[:email], subject: 'Emails подписка')
  end
end
