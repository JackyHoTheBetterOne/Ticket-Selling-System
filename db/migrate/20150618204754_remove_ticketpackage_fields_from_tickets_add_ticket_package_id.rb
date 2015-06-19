class RemoveTicketpackageFieldsFromTicketsAddTicketPackageId < ActiveRecord::Migration
  def change
    remove_column :tickets, :email
    remove_column :tickets, :name
    add_column :tickets, :ticket_package_id, :integer, index: true
  end
end
