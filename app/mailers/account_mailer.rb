class AccountMailer < ApplicationMailer
  def registration_confirmation(account)
    @account_name = account.name
    @account_email = account.email
    
    global_data = GlobalSetting.get(:application).value
    @project_name = global_data['project_name']
    @confirm_url = global_data['renderer_root'].to_s + "/register/confirm?confirm_token=#{account.confirmation_token}"
    mail to: account.email
  end
end
