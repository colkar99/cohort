class DropTableProgramCoordinate < ActiveRecord::Migration[5.2]
  def change
  	def up
    	drop_table :program_coordinates
  	end

  	def down
   	 raise ActiveRecord::IrreversibleMigration
 	 end
  end
end
