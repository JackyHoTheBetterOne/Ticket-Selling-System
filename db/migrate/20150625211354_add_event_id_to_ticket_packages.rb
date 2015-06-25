class AddEventIdToTicketPackages < ActiveRecord::Migration
  def change
    add_column :ticket_packages, :event_id, :integer, index: true
  end
end
