class AddAnswerToInquiries < ActiveRecord::Migration[5.1]
  def change
    add_column :inquiries, :answer, :text
  end
end
