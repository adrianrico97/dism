# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_23_141443) do

  create_table "accounts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "brands", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description"
    t.bigint "account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_brands_on_account_id"
  end

  create_table "devices", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description"
    t.text "observations"
    t.string "serial_number"
    t.string "code"
    t.string "category"
    t.decimal "price", precision: 10
    t.date "purchase_date"
    t.bigint "account_id"
    t.bigint "model_id"
    t.bigint "brand_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_devices_on_account_id"
    t.index ["brand_id"], name: "index_devices_on_brand_id"
    t.index ["model_id"], name: "index_devices_on_model_id"
  end

  create_table "devices_programs", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "device_id", null: false
    t.bigint "program_id", null: false
  end

  create_table "devices_users_relations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "device_id"
    t.bigint "user_id"
    t.date "assignment_date"
    t.date "deassignment_date"
    t.index ["device_id"], name: "index_devices_users_relations_on_device_id"
    t.index ["user_id"], name: "index_devices_users_relations_on_user_id"
  end

  create_table "issues", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "date"
    t.string "state"
    t.string "priority"
    t.bigint "device_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["device_id"], name: "index_issues_on_device_id"
    t.index ["user_id"], name: "index_issues_on_user_id"
  end

  create_table "models", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description"
    t.bigint "brand_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["brand_id"], name: "index_models_on_brand_id"
  end

  create_table "programs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "description"
    t.string "version"
    t.text "observations"
    t.bigint "account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_programs_on_account_id"
  end

  create_table "trackings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "description"
    t.datetime "date"
    t.bigint "issue_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["issue_id"], name: "index_trackings_on_issue_id"
    t.index ["user_id"], name: "index_trackings_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "login"
    t.string "password_digest"
    t.string "email"
    t.string "name"
    t.string "surname_1"
    t.string "surname_2"
    t.string "id_document_number"
    t.string "rol"
    t.boolean "active"
    t.bigint "account_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "locale"
    t.index ["account_id"], name: "index_users_on_account_id"
  end

end
