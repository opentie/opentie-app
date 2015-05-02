class AccountMailer < ApplicationMailer
  default from: "from@example.com"

  def registration_confirmation
    @text = "text"
    mail to: "to@example.com"
  end
end
