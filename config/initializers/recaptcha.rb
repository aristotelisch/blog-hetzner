Recaptcha.configure do |config|
  config.public_key = ENV['GOOGLE_RECAPTCHA_PUBLIC_KEY']
  config.private_key = ENV['GOOGLE_RECAPTCHA_PRIVATE_KEY']
end
