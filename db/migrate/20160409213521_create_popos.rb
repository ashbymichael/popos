class CreatePopos < ActiveRecord::Migration
  def change
    create_table :popos do |t|
      t.string :name
      t.float :lat
      t.float :long
      t.string :restrooms
      t.string :address
      t.string :image
      t.text :description
      t.string :hours
      t.string :restrooms
      t.string :address

      t.timestamps null: false
    end
  end
end
