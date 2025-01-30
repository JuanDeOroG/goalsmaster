class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.text :description, null: true
      t.timestamp :limit_time, null: true
      t.integer :goal_id, null: false
      t.integer :created_by, null: false
      t.integer :updated_by, null: false
      t.timestamps
      t.integer :state, null: false, default: 1
    end

    add_foreign_key :tasks, :goals, column: :goal_id
    add_foreign_key :tasks, :users, column: :created_by
    add_foreign_key :tasks, :users, column: :updated_by
  end
end
