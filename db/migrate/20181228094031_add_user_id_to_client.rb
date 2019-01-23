class AddUserIdToClient < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :user_id, :integer
  end
end
