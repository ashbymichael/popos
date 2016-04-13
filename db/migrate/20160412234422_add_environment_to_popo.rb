class AddEnvironmentToPopo < ActiveRecord::Migration
  def change
    add_column :popos, :environment, :string
  end
end
