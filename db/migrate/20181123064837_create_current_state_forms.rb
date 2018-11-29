class CreateCurrentStateForms < ActiveRecord::Migration[5.2]
  def change
    create_table :current_state_forms do |t|
      t.text :revenue
      t.text :traction
      t.text :solution_readiness
      t.text :investment
      t.text :team_velocity
      t.text :partners
      t.text :vendors
      t.text :vendors_costs
      t.text :experiment_testing
      t.text :customer_segment
      t.text :problem_validation
      t.text :channels
      t.text :governance
      t.references :startup_profile, foreign_key: true
      t.references :program, foreign_key: true
      t.integer :responser_id
      t.boolean :isActive, default: true
      t.boolean :isDelete, default: false
      t.integer :deleted_by
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
