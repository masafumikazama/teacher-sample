class AddInquiryToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :inquiry, :string
  end
end
