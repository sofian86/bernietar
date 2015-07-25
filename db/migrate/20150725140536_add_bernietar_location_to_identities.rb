class AddBernietarLocationToIdentities < ActiveRecord::Migration
  def change
    add_column :identities, :bernietar_location, :string
  end
end
