class AddFounderNameToStartupRegistration < ActiveRecord::Migration[5.2]
  def change
    add_column :startup_registrations, :founder_name, :string
    add_column :startup_registrations, :founder_email, :string
    add_column :startup_registrations, :founder_phone_number, :string
    add_column :startup_registrations, :founder_skills, :text
    add_column :startup_registrations, :founder_credentials, :text
    add_column :startup_registrations, :founder_experience, :text
    add_column :startup_registrations, :founder_commitment, :text
    add_column :startup_registrations, :startup_address_line_1, :string
    add_column :startup_registrations, :startup_address_line_2, :string
    add_column :startup_registrations, :startup_city, :string
    add_column :startup_registrations, :startup_state_province_region, :string
    add_column :startup_registrations, :startup_zip_pincode_postalcode, :string
    add_column :startup_registrations, :startup_country, :string
    add_column :startup_registrations, :startup_geo_location, :string
  end
end
