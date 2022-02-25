class TestMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email
    @articles = params[:articles]
    mail(to: 'test@mail.com', subject: 'Welcome to My Awesome Site')
  end
end
