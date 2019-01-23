class CreateTimeCards < ActiveRecord::Migration[5.2]
  def change
    create_table :time_cards do |t|
      t.text :description, :default => ""
      t.time :time
      t.date :date
      t.integer :client_id, :default => ""
      t.integer :card_id, :default => ""
      t.integer :tag_id, :default => ""

      t.timestamps
    end
  end
end
