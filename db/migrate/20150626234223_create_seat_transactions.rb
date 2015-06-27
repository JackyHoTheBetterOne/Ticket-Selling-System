class CreateSeatTransactions < ActiveRecord::Migration
  def change
    create_table :seat_transactions do |t|
      t.references :seat, index: true, foreign_key: true
      t.references :transaction_log, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
