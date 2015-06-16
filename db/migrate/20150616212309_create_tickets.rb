class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :seat_id
      t.text :barcode
      t.string :email
      t.string :name
      t.datetime :scan_time
      t.string :aasm_state

      t.timestamps null: false
    end
  end
end
