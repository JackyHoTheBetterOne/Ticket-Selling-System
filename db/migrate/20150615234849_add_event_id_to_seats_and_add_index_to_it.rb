class AddEventIdToSeatsAndAddIndexToIt < ActiveRecord::Migration
  def change
    add_column :seats, :event_id, :integer, index: true
  end
end
