class AddUserIdToCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :user_id, :integer
  end
end
