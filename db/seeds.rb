# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
unless User.find_by_email("telischristou@gmail.com")
  user1 = User.new(username: "aristotelis_ch", email: "telischristou@gmail.com", firstname: "Aristotelis", lastname: "Christou")
  user1.save
end
