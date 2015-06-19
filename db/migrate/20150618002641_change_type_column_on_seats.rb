class ChangeTypeColumnOnSeats < ActiveRecord::Migration
  def change
    remove_column :seats, :type
    add_column :seats, :seat_type, :string, default: "Regular"
  end
end
