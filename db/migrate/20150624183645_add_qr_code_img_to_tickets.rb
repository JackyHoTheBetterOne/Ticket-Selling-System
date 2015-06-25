class AddQrCodeImgToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :qr_code_img, :text
  end
end
