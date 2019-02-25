class RemoveFrameworkFromActivityResponses < ActiveRecord::Migration[5.2]
  def change
    remove_reference :activity_responses, :framework, foreign_key: true
  end
end
