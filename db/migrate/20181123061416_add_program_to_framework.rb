class AddProgramToFramework < ActiveRecord::Migration[5.2]
  def change
    add_reference :frameworks, :program, foreign_key: true
  end
end
