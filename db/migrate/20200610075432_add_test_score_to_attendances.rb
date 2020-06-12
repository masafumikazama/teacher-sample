class AddTestScoreToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :test_score, :integer
  end
end
