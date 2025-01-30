# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_01_29_171241) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "goals", force: :cascade do |t|
    t.string "code", default: -> { "gen_random_uuid()" }, null: false
    t.string "title", null: false
    t.text "description"
    t.datetime "limit_time", precision: nil
    t.integer "user_id", null: false
    t.integer "created_by", null: false
    t.integer "updated_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "state", default: 1, null: false
  end

  create_table "parameter_values", force: :cascade do |t|
    t.string "name", null: false
    t.integer "state", null: false
    t.integer "parameter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_parameter_values_on_name", unique: true
  end

  create_table "parameters", force: :cascade do |t|
    t.string "name", null: false
    t.integer "state", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_parameters_on_name", unique: true
  end

  create_table "permissions", force: :cascade do |t|
    t.string "name", null: false
    t.integer "state", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_permissions_on_name", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.integer "state", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "roles_permissions", force: :cascade do |t|
    t.bigint "role_id", null: false
    t.bigint "permission_id", null: false
    t.integer "state", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_id"], name: "index_roles_permissions_on_permission_id"
    t.index ["role_id", "permission_id"], name: "index_roles_permissions_on_role_id_and_permission_id", unique: true
    t.index ["role_id"], name: "index_roles_permissions_on_role_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "limit_time", precision: nil
    t.integer "goal_id", null: false
    t.integer "created_by", null: false
    t.integer "updated_by", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "state", default: 1, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "code", default: -> { "gen_random_uuid()" }, null: false
    t.string "username", default: "", null: false
    t.string "email", default: "", null: false
    t.integer "role_id", default: 0, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "state", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_users_on_code", unique: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "goals", "users"
  add_foreign_key "goals", "users", column: "created_by"
  add_foreign_key "goals", "users", column: "updated_by"
  add_foreign_key "parameter_values", "parameters", on_delete: :cascade
  add_foreign_key "roles_permissions", "permissions"
  add_foreign_key "roles_permissions", "roles"
  add_foreign_key "tasks", "goals"
  add_foreign_key "tasks", "users", column: "created_by"
  add_foreign_key "tasks", "users", column: "updated_by"
end
