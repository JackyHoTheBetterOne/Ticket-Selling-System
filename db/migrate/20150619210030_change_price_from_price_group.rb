class ChangePriceFromPriceGroup < ActiveRecord::Migration
  def change
    change_column :price_groups, :price, :float, default: 0
  end
end
