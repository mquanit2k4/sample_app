class ApplicationMailer < ActionMailer::Base
  default from: Settings.default_send_email
  layout "mailer"
end
