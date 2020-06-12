class CreateInquiries < ActiveRecord::Migration[5.1]
  def change
    create_table :inquiries do |t|
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :inquiries, [:user_id, :created_at]
  end
end
