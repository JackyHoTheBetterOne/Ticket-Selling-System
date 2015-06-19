class AddIndexToSeatName < ActiveRecord::Migration
  def change
    add_index :seats, :name
  end
end
