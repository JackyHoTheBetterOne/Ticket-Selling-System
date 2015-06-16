class AddingRelatonshipsForTicketsAndIndex < ActiveRecord::Migration
  def change
    add_column :seats, :ticket_id, :integer, index: true
    add_index :tickets, :seat_id
    add_column :tickets, :event_id, :integer, index: true 
  end
end
