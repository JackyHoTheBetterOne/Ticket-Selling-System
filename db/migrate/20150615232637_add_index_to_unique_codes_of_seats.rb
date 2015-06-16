class AddIndexToUniqueCodesOfSeats < ActiveRecord::Migration
  def change
    add_index :seats, :unique_code
  end
end
