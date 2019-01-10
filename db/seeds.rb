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
ModuleType.create!(name: "role_user", description: "This module used to give permission to role_user modules")
ModuleType.create!(name: "program_type", description: "This module used to give permission to program type modules")
ModuleType.create!(name: "program_location", description: "This module used to give permission to program location modules")
ModuleType.create!(name: "program", description: "This module used to give permission to program modules")
ModuleType.create!(name: "current_state_form", description: "This module used to give permission to current state formmodules")
ModuleType.create!(name: "roadmap", description: "This module used to give permission to roadmap")
ModuleType.create!(name: "startup_application", description: "this module used to startup registration")
ModuleType.create!(name: "application_question",description: "this module used to program reg questions")
ModuleType.create!(name: "app_ques_response",description: "this module used to program reg questions")
ModuleType.create!(name: "contract_form",description: "this module used to controll contract form")
ModuleType.create!(name: "startup_profile",description: "this module used to controll startup profile")
ModuleType.create!(name: "additional_contract_information",description: "this module used to controll additional contract informations")

# user
# role
# user_role
# current_state_form
# roadmap
# startup_application
# app_ques_response
# contract_form
# startup_profile
puts  "Modules created"

Role.create!(name: "site_admin" ,user_role_type: "site")
Role.create!(name: "program_admin", user_role_type: "site")
Role.create!(name: "program_director",user_role_type: "site")
Role.create!(name: "application_manager",user_role_type: "site")
Role.create!(name: "contract_manager",user_role_type: "site")
Role.create!(name: "startup_admin",user_role_type: "startup")

puts  "Roles created"

User.create!(first_name: "admin",last_name: "test",email: "admin@gmail.com", phone_number: "8056756218", password: "123456", password_confirmation: "123456",user_type: "site")
User.create!(first_name: "app",last_name: "manager",email: "manager@gmail.com", phone_number: "8056756218", password: "123456", password_confirmation: "123456", user_type: "site")
User.create!(first_name: "contract",last_name: "manager",email: "contract@gmail.com", phone_number: "8056756218", password: "123456", password_confirmation: "123456", user_type: "site")
User.create!(first_name: "program",last_name: "director",email: "director@gmail.com", phone_number: "8056756218", password: "123456", password_confirmation: "123456", user_type: "site")

puts  " users created"

ModuleType.all.each do |mo_type|
	UserRole.create!(user_id: 1,role_id: 1, module_type_id: mo_type.id,create_rule: true,update_rule: true, delete_rule: true, show_rule: true, user_role_type: "site")
end

puts "user role created"

ProgramStatus.create!(status:"PR",description: "Application registered" ,stage: "auto")
ProgramStatus.create!(status:"RP",description: "Reviews pending by admin" ,stage: "initial")
ProgramStatus.create!(status:"RC",description: "Reviews completed by admin" ,stage: "initial")
ProgramStatus.create!(status:"AA",description: "Accepted", stage: "initial")
ProgramStatus.create!(status:"AR",description: "Rejected", stage: "initial")
ProgramStatus.create!(status:"CFR",description: "Contract form received", stage: "contract")
ProgramStatus.create!(status:"CSWFP",description: "Contract form Signed waiting for approval", stage: "contract")
ProgramStatus.create!(status:"CFA",description: "Contract form approved by C_manager", stage: "contract")
ProgramStatus.create!(status:"SPC",description: "Startup profile created", stage: "profile_creation")
ProgramStatus.create!(status:"CSFS",description: "Current state form submitted", stage: "current_state_form")
ProgramStatus.create!(status:"CSFR",description: "Current state form reviewed", stage: "current_state_form")
puts "program_status created"

AdditionalContractInformation.create!(purpose_of_contract: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",contract_termination: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", contract_terms_condition: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",authorization: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
puts "additional contract information created"
# UserRole.create!(user_id: 1,role_id: 1, module_type_id: 12,create_rule: true,update_rule: true, delete_rule: true, show_rule: true)
 