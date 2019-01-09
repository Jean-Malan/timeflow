class AddUserIdToTimeCard < ActiveRecord::Migration[5.2]
  def change
    add_column :time_cards, :user_id, :integer
  end
end
