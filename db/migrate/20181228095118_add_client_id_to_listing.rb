class AddClientIdToListing < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :client_id, :string
    add_column :listings, :integer, :string
  end
end
