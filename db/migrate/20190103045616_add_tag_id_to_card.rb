class AddTagIdToCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :tag_id, :integer, :default => 1
  end
end
