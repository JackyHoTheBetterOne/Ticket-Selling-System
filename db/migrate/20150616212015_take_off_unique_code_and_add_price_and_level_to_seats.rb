class TakeOffUniqueCodeAndAddPriceAndLevelToSeats < ActiveRecord::Migration
  def change
    remove_column :seats, :unique_code
    add_column :seats, :price, :float, default: 99.99
    add_column :seats, :level, :integer, default: 1
  end
end
