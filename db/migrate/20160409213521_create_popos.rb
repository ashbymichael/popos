class CreatePopos < ActiveRecord::Migration
  def change
    create_table :popos do |t|
      t.string  :name
      t.float   :lat
      t.float   :lng
      t.string  :address
      t.string  :location_type
      t.text    :location
      t.string  :image
      t.text    :description
      t.string  :hours
      t.string  :hours_type
      t.string  :restrooms
      t.text    :landscape
      t.string  :accessibility
      t.integer :year
      t.boolean :seating
      t.text    :seating_description

      t.timestamps null: false
    end
  end
end
