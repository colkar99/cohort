class RemoveFrameworkReferenceFromActivity < ActiveRecord::Migration[5.2]
  def change
    remove_reference :activities, :framework, foreign_key: true
  end
end
