class CreatePriceGroups < ActiveRecord::Migration
  def change
    create_table :price_groups do |t|
      t.integer :price
      t.references :event, index: true


      t.timestamps null: false
    end
    add_foreign_key :price_groups, :events, on_delete: :cascade
  end
end
