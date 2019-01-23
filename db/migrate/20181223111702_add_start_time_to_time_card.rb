class AddStartTimeToTimeCard < ActiveRecord::Migration[5.2]
  def change
    add_column :time_cards, :start_time, :time
    add_column :time_cards, :end_time, :time
  end
end
