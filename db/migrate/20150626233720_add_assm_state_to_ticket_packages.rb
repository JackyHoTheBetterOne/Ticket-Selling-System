class AddAssmStateToTicketPackages < ActiveRecord::Migration
  def change
    add_column :ticket_packages, :aasm_state, :string
    add_column :ticket_packages, :deleted_state_at, :datetime
  end
end
