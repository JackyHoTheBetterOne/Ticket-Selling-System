class CreateTicketPackages < ActiveRecord::Migration
  def change
    create_table :ticket_packages do |t|
      t.string :name
      t.string :email
      t.timestamps null: false
    end
  end
end
