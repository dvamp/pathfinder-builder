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

ActiveRecord::Schema.define(version: 5) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dragon_age_categories", id: :serial, force: :cascade do |t|
    t.string "age_category"
    t.string "age_in_years"
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

  create_table "dragon_race_ages", id: :serial, force: :cascade do |t|
    t.integer "race_id"
    t.integer "age_id"
    t.text "sense"
    t.text "aura"
    t.text "defensive_ability"
    t.string "dr"
    t.integer "sr"
    t.text "additional_move"
    t.text "special_attack"
    t.text "sp"
    t.integer "caster_level"
    t.string "caster_source"
    t.text "sq"
  end

  create_table "dragon_races", id: :serial, force: :cascade do |t|
    t.integer "category_id"
    t.string "name"
    t.string "alignment"
    t.string "creature_category"
    t.string "creature_subcategory"
    t.integer "cr"
    t.integer "size"
    t.integer "hit_dice"
    t.string "immune"
    t.string "weakness"
    t.string "land_speed"
    t.string "burrow_speed"
    t.string "swim_speed"
    t.integer "natural_armor"
    t.string "breath_shape"
    t.integer "breath_damage_num"
    t.string "breath_damage_dice"
    t.string "breath_category"
    t.integer "str"
    t.integer "dex"
    t.integer "con"
    t.integer "int"
    t.integer "wis"
    t.integer "chr"
    t.string "racial_modifer"
    t.string "language"
    t.string "env"
    t.string "organization"
    t.string "treasure"
  end

  create_table "fly_muverabillities", id: :serial, force: :cascade do |t|
    t.string "name"
  end

  create_table "size_categories", id: :serial, force: :cascade do |t|
    t.integer "size_id"
    t.string "name"
    t.string "pose"
    t.integer "ba_size_modifer"
    t.integer "cmb_size_modifer"
    t.string "space"
    t.string "reach"
    t.string "bite_reach"
    t.string "fly_speed"
    t.string "fly_muverabillity"
    t.string "bite_damage"
    t.string "claws_damage"
    t.string "wings_damage"
    t.string "tail_slap_damage"
    t.string "crush_damage"
    t.string "tail_sweep_damage"
    t.string "breath_range_line"
    t.string "breath_range_cone"
  end

end
