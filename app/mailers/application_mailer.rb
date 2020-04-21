class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@your_domain.com'
  layout 'mailer'
end
