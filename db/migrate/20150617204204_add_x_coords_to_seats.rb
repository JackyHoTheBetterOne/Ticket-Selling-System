class AddXCoordsToSeats < ActiveRecord::Migration
  def change
    add_column :seats, :x_coor, :float
  end
end
