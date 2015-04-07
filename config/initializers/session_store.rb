# Be sure to restart your server when you modify this file.

# Rails.application.config.session_store :cookie_store, key: '_opentie-app_session'

Rails.application.config.session_store(
  :cookie_store,
  key: '_opentie-app_session'
)
#Rails.application.config.session_store(
#  :redis_store,
#  :servers => "redis://localhost:6379/1",
#  :expire_after => 30.minutes
#)
