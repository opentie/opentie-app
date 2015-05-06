class AccountMailer < ApplicationMailer
  layout 'basic'

  def registration_confirmation(account)
    @account_name = account.name
    @account_email = account.email

    @global_setting = GlobalSetting.get(:application).value
    @confirm_url = @global_setting['renderer_root'].to_s + "/register/confirm?confirm_token=#{account.confirmation_token}"
    mail to: account.email
  end

  def invitation(email, from_account)
    @email = email
    @from_account_name = from_account.name
    @from_account_email = from_account.email

    @global_setting = GlobalSetting.get(:application).value
    @project_name = @global_setting['project_name']
    @register_url = @global_setting['renderer_root'].to_s
    mail to: email
  end
end
