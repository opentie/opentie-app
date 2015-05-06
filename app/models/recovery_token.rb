class RecoveryToken < ActiveRecord::Base
  belongs_to :account

  def is_valid?
    # token is valid for 1 hour and one time
    (created_at > 1.hour.ago) && (! resetted_password)
  end

  def self.create_new_token(account_id)
    token = SecureRandom.urlsafe_base64(50)
    t = create(token: token, account_id: account_id)
    t.save
    token
  end

  def self.has_valid_token?(account_id)
    (where(account_id: account_id, resetted_password: false).try(:where, ["created_at > ?", 1.hour.ago]) || []).size > 0
  end
end
