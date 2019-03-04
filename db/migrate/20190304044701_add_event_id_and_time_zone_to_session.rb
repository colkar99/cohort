class AddEventIdAndTimeZoneToSession < ActiveRecord::Migration[5.2]
  def change
    add_column :sessions, :event_id, :string
    add_column :sessions, :time_zone, :string
  end
end
