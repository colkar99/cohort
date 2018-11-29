class RemoveLocationFromProgram < ActiveRecord::Migration[5.2]
  def change
    remove_reference :programs, :location, foreign_key: true
  end
end
