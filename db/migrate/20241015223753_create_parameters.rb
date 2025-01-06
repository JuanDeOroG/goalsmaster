class CreateParameters < ActiveRecord::Migration[7.2]
  def change
    create_table :parameters do |t|
      t.string :name, null: false
      t.integer :state, null: false

      t.timestamps
    end

    add_index :parameters, :name, unique: true
  end
end
