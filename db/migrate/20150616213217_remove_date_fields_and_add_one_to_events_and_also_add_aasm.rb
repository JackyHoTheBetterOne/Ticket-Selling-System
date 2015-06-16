class RemoveDateFieldsAndAddOneToEventsAndAlsoAddAasm < ActiveRecord::Migration
  def change
    remove_column :events, :start_date
    remove_column :events, :end_date
    add_column :events, :show_date, :datetime
    add_column :events, :aasm_state, :string
  end
end
