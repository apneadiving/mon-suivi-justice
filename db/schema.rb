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

ActiveRecord::Schema.define(version: 2021_07_09_085429) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agendas", force: :cascade do |t|
    t.string "name"
    t.bigint "place_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["place_id"], name: "index_agendas_on_place_id"
  end

  create_table "appointment_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "place_type", default: 0
  end

  create_table "appointments", force: :cascade do |t|
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "convict_id", null: false
    t.bigint "slot_id", null: false
    t.bigint "appointment_type_id", null: false
    t.string "state"
    t.index ["appointment_type_id"], name: "index_appointments_on_appointment_type_id"
    t.index ["convict_id"], name: "index_appointments_on_convict_id"
    t.index ["slot_id"], name: "index_appointments_on_slot_id"
  end

  create_table "convicts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "title", default: 0
    t.boolean "no_phone"
    t.boolean "refused_phone"
  end

  create_table "notification_types", force: :cascade do |t|
    t.bigint "appointment_type_id"
    t.text "template"
    t.integer "role", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "reminder_period", default: 0
    t.index ["appointment_type_id"], name: "index_notification_types_on_appointment_type_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "name"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "appointment_id", null: false
    t.integer "role", default: 0
    t.string "template"
    t.integer "reminder_period", default: 0
    t.index ["appointment_id"], name: "index_notifications_on_appointment_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "name"
    t.string "adress"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "place_type", default: 0
  end

  create_table "slot_types", force: :cascade do |t|
    t.integer "week_day", default: 0
    t.time "starting_time"
    t.integer "duration", default: 30
    t.integer "capacity", default: 1
    t.bigint "appointment_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["appointment_type_id"], name: "index_slot_types_on_appointment_type_id"
  end

  create_table "slots", force: :cascade do |t|
    t.date "date"
    t.time "starting_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "available", default: true
    t.integer "duration", default: 30
    t.integer "capacity", default: 1
    t.integer "used_capacity", default: 0
    t.bigint "appointment_type_id", null: false
    t.bigint "agenda_id", default: 1, null: false
    t.index ["agenda_id"], name: "index_slots_on_agenda_id"
    t.index ["appointment_type_id"], name: "index_slots_on_appointment_type_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role", default: 0
    t.string "first_name"
    t.string "last_name"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.bigint "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "agendas", "places"
  add_foreign_key "appointments", "appointment_types"
  add_foreign_key "appointments", "convicts"
  add_foreign_key "appointments", "slots"
  add_foreign_key "notification_types", "appointment_types"
  add_foreign_key "notifications", "appointments"
  add_foreign_key "slot_types", "appointment_types"
  add_foreign_key "slots", "agendas"
  add_foreign_key "slots", "appointment_types"
end
