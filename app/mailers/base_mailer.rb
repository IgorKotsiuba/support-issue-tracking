class BaseMailer < ActionMailer::Base
  default from: 'info@company.com'
  layout 'mailer'
end
