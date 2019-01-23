class AddRecordedTimeToTimeCard < ActiveRecord::Migration[5.2]
  def change
    add_column :time_cards, :recorded_time, :integer
  end
end
