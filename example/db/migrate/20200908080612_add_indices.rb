class AddIndices < ActiveRecord::Migration[6.0]
  def change
    add_index :buildings, :uuid, unique: true
    add_index :firms, :uuid, unique: true
    add_index :firms, :building_uuid
    add_index :users, :uuid, unique: true
    add_index :users, :firm_uuid
  end
end
