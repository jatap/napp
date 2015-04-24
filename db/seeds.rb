# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

['user', 'editor', 'admin'].each do |role|
    Role.find_or_create_by({name: role})
end

User.create! fullname: "Administrador", email: "julio.antunez.tarin@gmail.com",
             password: "Malament",
             profile:  UserProfile.create!(first_name: 'Administrador',
                                            last_name: 'Sistemas'),
             roles: [
               Role.find_by_name(:user),
               Role.find_by_name(:editor),
               Role.find_by_name(:admin)
             ]

Site.create! name: "Napp website",
  version: "1.0.0",
  author: "Julio Antúnez Tarín",
  banner: "Enjoy your code time.",
  email: "julio.antunez.tarin@gmail.com",
  twitter: "http://twitter.com/napp",
  facebook: "http://www.facebook.com/napp",
  linkedin: "http://es.linkedin.com/pub/julio-antúnez-tarín/22/900/3/es",
  google_plus: "http://plus.google.com/+Napp/posts"
