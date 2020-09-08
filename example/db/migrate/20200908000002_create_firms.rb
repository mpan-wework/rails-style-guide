class CreateFirms < ActiveRecord::Migration[6.0]
  def change
    create_table :firms, comment: 'Company' do |t|
      t.uuid :uuid, null: false, default: 'uuid_generate_v4()'
      t.string :name, null: false
      t.uuid :building_uuid, null: false

      t.timestamps
    end
  end
end
