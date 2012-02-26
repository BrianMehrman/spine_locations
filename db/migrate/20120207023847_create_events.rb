class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.integer :location_id
      t.string :description
      t.date :start

      t.timestamps
    end
  end
end
