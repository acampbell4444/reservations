if Rails.env.development? || Rails.env.production?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address: 'smtp.gmail.com',
    port: '587',
    domain: 'gmail.com',
    user_name: 'alantest44@gmail.com',
    password: 'password',
    authentication: :login,
    enable_starttls_auto: true,
    openssl_verify_mode: 'none'
  }
end
