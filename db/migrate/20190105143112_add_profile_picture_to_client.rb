class AddProfilePictureToClient < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :profile_picture, :string
  end
end
