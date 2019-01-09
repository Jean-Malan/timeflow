class AddCardColorToCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :card_color, :string
    add_column :cards, :tag, :string
  end
end
