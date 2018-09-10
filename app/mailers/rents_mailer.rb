class RentsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.rents_mailer.new_rent_notification.subject
  #
  def new_rent_notification(rent)
    @rent = rent
    puts 'serialized rent'
    puts @rent.object
    puts @rent.object.user.email
    puts 'end serizlized rent'
    mail to: @rent.object.user.email, from: 'no-reply@wolox.cl', subject: 'You got a new rent'
  end
end
