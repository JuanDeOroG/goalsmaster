class CreateParameterValues < ActiveRecord::Migration[7.2]
  def change
    create_table :parameter_values do |t|
      t.string :name, null: false
      t.integer :state, null: false
      t.integer :parameter_id

      t.timestamps
    end

    add_index :parameter_values, :name, unique: true

    # Definir la clave foránea directamente al crear la columna
    add_foreign_key :parameter_values, # donde se encuentra la fk
     :parameters, # La tabla relacionada
     column: :parameter_id, # el campo que es llave foranea
     on_delete: :cascade # Cuando se elimine un parametro, se eliminarán los valores parametros que estén relacionados a él
  end
end
