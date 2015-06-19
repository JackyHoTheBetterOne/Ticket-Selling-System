class RemovePriceAndAddPriceGroupToSeats < ActiveRecord::Migration
  def change
    remove_column :seats, :price
    add_column :seats, :price_group_id, :integer, index: true
  end
end
