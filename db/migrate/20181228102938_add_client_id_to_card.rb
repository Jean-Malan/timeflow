class AddClientIdToCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :client_id, :integer
  end
end
