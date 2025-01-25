class CreateGoals < ActiveRecord::Migration[7.2]
  def change
    create_table :goals do |t|
      t.string :code, null: false, default: -> { "gen_random_uuid()" }
      t.string :title, null: false
      t.text :description, null: true
      t.timestamp :limit_time, null: true
      t.integer :user_id, null: false
      t.integer :created_by, null: false
      t.integer :updated_by, null: false
      t.timestamps
      t.integer :state, null: false, default: 1
    end

    add_foreign_key :goals, :users, column: :user_id
    add_foreign_key :goals, :users, column: :created_by
    add_foreign_key :goals, :users, column: :updated_by
  end
end
