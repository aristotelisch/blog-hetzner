namespace :cache do
  desc "Clears cache"
  task clear: :environment do
    Rails.cache.clear
    puts 'Cache cleared.'
  end
end
