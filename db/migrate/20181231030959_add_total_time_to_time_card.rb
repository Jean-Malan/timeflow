class AddTotalTimeToTimeCard < ActiveRecord::Migration[5.2]
  def change
    add_column :time_cards, :total_time, :string
  end
end
