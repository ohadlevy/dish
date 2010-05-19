# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100519053809) do

  create_table "arches", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hosts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "muxes", :id => false, :force => true do |t|
    t.integer "host_id",    :null => false
    t.integer "package_id", :null => false
    t.integer "version_id", :null => false
    t.integer "arch_id",    :null => false
    t.integer "os_id",      :null => false
  end

  add_index "muxes", ["arch_id"], :name => "index_muxes_on_arch_id"
  add_index "muxes", ["host_id", "package_id"], :name => "index_muxes_on_host_id_and_package_id"
  add_index "muxes", ["host_id"], :name => "index_muxes_on_host_id"
  add_index "muxes", ["os_id"], :name => "index_muxes_on_os_id"
  add_index "muxes", ["package_id"], :name => "index_muxes_on_package_id"
  add_index "muxes", ["version_id", "package_id"], :name => "index_muxes_on_version_id_and_package_id"
  add_index "muxes", ["version_id"], :name => "index_muxes_on_version_id"

  create_table "os", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "packages", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "versions", :force => true do |t|
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
