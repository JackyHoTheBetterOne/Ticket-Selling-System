class CreateTransactionLogs < ActiveRecord::Migration
  def change
    create_table :transaction_logs do |t|
      t.datetime :date
      t.integer :transaction_num
      t.string :transaction_type
      t.text :notes

      t.timestamps null: false
    end
  end
end
