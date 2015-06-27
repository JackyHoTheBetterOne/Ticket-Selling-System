class CreateTicketPackageTransactions < ActiveRecord::Migration
  def change
    create_table :ticket_package_transactions do |t|
      t.references :ticket_package, index: true, foreign_key: true
      t.references :transaction_log, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
