class AddTypeToSeats < ActiveRecord::Migration
  def change
    add_column :seats, :type, :string, default: "R"
  end
end
