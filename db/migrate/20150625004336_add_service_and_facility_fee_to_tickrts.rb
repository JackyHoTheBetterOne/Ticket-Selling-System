class AddServiceAndFacilityFeeToTickrts < ActiveRecord::Migration
  def change
    add_column :events, :service_fee, :float, default: 0
    add_column :events, :facility_fee, :float, default: 0
  end
end
