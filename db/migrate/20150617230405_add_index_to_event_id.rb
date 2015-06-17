class AddIndexToEventId < ActiveRecord::Migration
  def change
    add_index :seats, :event_id
    add_index :tickets, :event_id
  end
end
