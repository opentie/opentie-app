class AccountMailer < ApplicationMailer
  def registration_confirmation
    @text = params[:text]
    mail to: params[:to]
  end
end
