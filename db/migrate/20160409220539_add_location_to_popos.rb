class AddLocationToPopos < ActiveRecord::Migration
  def change
    add_column :popos, :location, :string
  end
end
