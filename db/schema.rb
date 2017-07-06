# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170706132501) do

  create_table "contracts", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoices", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.date     "due_date"
    t.decimal  "total",            precision: 10, scale: 2
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "renting_phase_id"
    t.index ["renting_phase_id"], name: "index_invoices_on_renting_phase_id"
  end

  create_table "line_items", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "unit_price", precision: 10, scale: 2
    t.decimal  "total",      precision: 10, scale: 2
    t.integer  "units"
    t.integer  "invoice_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["invoice_id"], name: "index_line_items_on_invoice_id"
  end

  create_table "renting_phases", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.decimal  "price",       precision: 10, scale: 2
    t.integer  "cycles"
    t.integer  "contract_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["contract_id"], name: "index_renting_phases_on_contract_id"
  end

end
