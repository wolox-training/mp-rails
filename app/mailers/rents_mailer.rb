class RentsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #bundle exec sidekiq --environment development -C config/sidekiq.yml
  #   en.rents_mailer.new_rent_notification.subject
  #
  def new_rent_notification(rent_id)
    @rent = Rent.find(rent_id)
    mail to: @rent.user['email'], from: 'no-reply@wolox.cl', subject: 'You just rented a book'
  end
end
