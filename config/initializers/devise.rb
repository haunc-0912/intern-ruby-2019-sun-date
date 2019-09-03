Devise.setup do |config|
  config.mailer_sender =  ENV["SENDMAIL_USERNAME"]

  require "devise/orm/active_record"

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 11
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 3..128
  config.email_regexp = Settings.validate.VALID_EMAIL_REGEX
  config.reset_password_within = 1.hours
  config.sign_out_via = :delete
  config.scoped_views = true
  config.omniauth :facebook, ENV["app_id"], ENV["app_secret"], callback_url: ENV["callback_url"]
end
