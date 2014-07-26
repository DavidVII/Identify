ActionMailer::Base.smtp_settings = {
  address: 'smtp.mandrillapp.com',
  port: 587,
  enable_starttls_auto: true,
  user_name: ENV['MANDRILL_API_EMAIL'],
  password: ENV['MANDRILL_API_KEY'],
  authentication: 'login',
  domain: 'pacific-woodland-2616.herokuapp.com'
}

ActionMailer::Base.default charset: 'utf-8'

if Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
end
