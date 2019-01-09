class RenameListColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :cards, :list_id, :listing_id
  end
end
