class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :capacity
      t.references :building, index: true

      t.timestamps
    end
  end
end
