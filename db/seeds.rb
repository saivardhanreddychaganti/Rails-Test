# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
roles = ['superAdmin', 'participant']
roles.each do |role|
	Role.where(name: role).first_or_create
end

users = User.where(email: 'admin@example.com')

if users.count == 0
	admin_role  = Role.where(name: roles.first).first
	user = User.create!(email: 'admin@example.com', password: 'password')
	user.roles << admin_role
end