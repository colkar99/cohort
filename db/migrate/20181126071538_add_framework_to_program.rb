class AddFrameworkToProgram < ActiveRecord::Migration[5.2]
  def change
    add_reference :programs, :framework, foreign_key: true
  end
end
