class AddKeywordsTicketPackage < ActiveRecord::Migration
  def change
    add_column :ticket_packages, :keywords, :text
  end
end
