class CreateRoles < ActiveRecord::Migration[7.2]
  def change
    create_table :roles do |t|
      t.string :name, null: false, default: ""
      t.integer :state, null: false, default: 0
      t.timestamps
    end
    # Role names must be uniques
    add_index :roles, :name, unique: true 
  end
end
