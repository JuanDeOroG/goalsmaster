class CreatePermissions < ActiveRecord::Migration[7.2]
  def change
    create_table :permissions do |t|
      t.string :name, null: false
      t.integer :state, null: false, default: 0
      t.timestamps
    end
    add_index :permissions, :name, unique: true
  end
end
