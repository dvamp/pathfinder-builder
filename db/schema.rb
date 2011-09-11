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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 2) do

  create_table "dragon_age_categories", :force => true do |t|
    t.string  "age_category"
    t.string  "age_in_years"
    t.integer "cr"
    t.integer "size"
    t.integer "hit_dice"
    t.integer "natural_armor"
    t.integer "breath"
    t.integer "str"
    t.integer "dex"
    t.integer "con"
    t.integer "int"
    t.integer "wis"
    t.integer "chr"
  end

  create_table "dragon_races", :force => true do |t|
    t.integer "category_id"
    t.string  "name"
    t.string  "alignment"
    t.string  "creature_category"
    t.string  "creature_subcategory"
    t.integer "cr"
    t.integer "size"
    t.integer "hit_dice"
    t.string  "speed"
    t.integer "natural_armor"
    t.string  "breath_shape"
    t.integer "breath_damage_num"
    t.string  "breath_damage_dice"
    t.string  "breath_category"
    t.integer "str"
    t.integer "dex"
    t.integer "con"
    t.integer "int"
    t.integer "wis"
    t.integer "chr"
    t.string  "env"
    t.string  "organization"
    t.string  "treasure"
  end

end
