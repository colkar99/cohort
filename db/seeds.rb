# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ModuleType.create!(name: "user", description: "This module used to give permission to user_modules")
ModuleType.create!(name: "role", description: "This module used to give permission to user_modules")
ModuleType.create!(name: "user_role", description: "This module used to give permission to user role modules")
ModuleType.create!(name: "program_type", description: "This module used to give permission to program type modules")
ModuleType.create!(name: "program_location", description: "This module used to give permission to program location modules")
ModuleType.create!(name: "program", description: "This module used to give permission to program modules")
ModuleType.create!(name: "current_state_form", description: "This module used to give permission to current state formmodules")
ModuleType.create!(name: "roadmap", description: "This module used to give permission to roadmap")
ModuleType.create!(name: "startup_application","description": "this module used to startup registration")

puts  "Modules created"

Role.create!(name: "site_admin")
Role.create!(name: "program_admin")
Role.create!(name: "program_director")
Role.create!(name: "application_manager")
Role.create!(name: "contract_manager")

puts  "Roles created"

User.create!(first_name: "admin",last_name: "test",email: "admin@gmail.com", phone_number: "8056756218", password: "123456", password_confirmation: "123456",user_type: "site")
User.create!(first_name: "app",last_name: "manager",email: "manager@gmail.com", phone_number: "8056756218", password: "123456", password_confirmation: "123456", user_type: "site")
User.create!(first_name: "contract",last_name: "manager",email: "contract@gmail.com", phone_number: "8056756218", password: "123456", password_confirmation: "123456", user_type: "site")
User.create!(first_name: "program",last_name: "director",email: "director@gmail.com", phone_number: "8056756218", password: "123456", password_confirmation: "123456", user_type: "site")

puts  " users created"

ModuleType.all.each do |mo_type|
	UserRole.create!(user_id: 1,role_id: 1, module_type_id: mo_type.id,create_rule: true,update_rule: true, delete_rule: true, show_rule: true)
end

puts "user role created"

ProgramStatus.create!(status:"PR",description: "program registered")
puts "program_status created"
