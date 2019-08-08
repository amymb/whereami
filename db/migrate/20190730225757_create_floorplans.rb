class CreateFloorplans < ActiveRecord::Migration[5.2]
  def change
    create_table :floorplans do |t|
      t.string :image
      t.string :location
      t.string :floor
      t.string :corner_coordinates

      t.timestamps
    end
  end
end
