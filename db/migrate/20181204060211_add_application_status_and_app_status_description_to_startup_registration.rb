class AddApplicationStatusAndAppStatusDescriptionToStartupRegistration < ActiveRecord::Migration[5.2]
  def change
    add_column :startup_registrations, :application_status, :string
    add_column :startup_registrations, :app_status_description, :string
  end
end
