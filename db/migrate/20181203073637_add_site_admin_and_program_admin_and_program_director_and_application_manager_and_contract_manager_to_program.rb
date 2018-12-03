class AddSiteAdminAndProgramAdminAndProgramDirectorAndApplicationManagerAndContractManagerToProgram < ActiveRecord::Migration[5.2]
  def change
    add_column :programs, :site_admin, :integer
    add_column :programs, :program_admin, :integer
    add_column :programs, :program_director, :integer
    add_column :programs, :application_manager, :integer
    add_column :programs, :contract_manager, :integer
  end
end
