class CreateSeats < ActiveRecord::Migration
  def change
    create_table :seats do |t|
      t.string :row
      t.string :column
      t.string :section
      t.string :aasm_state
      t.text :unique_code
      t.string :name

      t.timestamps null: false
    end
  end
end
