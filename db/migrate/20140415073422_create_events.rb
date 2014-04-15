class CreateEvents < ActiveRecord::Migration
  def change
    change_table :events do |t|

      t.remove :end_tine
      t.integer :end_time


    end
  end
end
