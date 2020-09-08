class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, comment: 'Member' do |t|
      t.uuid :uuid, null: false, default: 'uuid_generate_v4()'
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.string :firm_uuid, null: false

      t.timestamps
    end
  end
end
