Airbrake.configure do |config|
  config.host = ENV['AIRBRAKE_URL']
  config.project_id = true
  config.project_key = ENV['AIRBRAKE_KEY']
end
