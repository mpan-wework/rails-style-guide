class CreateBuildings < ActiveRecord::Migration[6.0]
  def change
    create_table :buildings, comment: 'Community/Location' do |t|
      t.uuid :uuid, null: false, default: 'uuid_generate_v4()'
      t.string :name, null: false

      t.timestamps
    end
  end
end
