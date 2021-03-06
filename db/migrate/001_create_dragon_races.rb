class CreateDragonRaces < ActiveRecord::Migration[4.2]
  def self.up
    create_table :dragon_races do |t|
      t.integer :category_id
      t.string :name
      t.string :alignment
      t.string :creature_category
      t.string :creature_subcategory
      t.integer :cr
      t.integer :size
      t.integer :hit_dice
      t.string :immune
      t.string :weakness
      t.string :land_speed
      t.string :burrow_speed
      t.string :swim_speed
      t.integer :natural_armor
      t.string :breath_shape
      t.integer :breath_damage_num
      t.string :breath_damage_dice
      t.string :breath_category
      t.integer :str
      t.integer :dex
      t.integer :con
      t.integer :int
      t.integer :wis
      t.integer :chr
      t.string :racial_modifer
      t.string :language
      t.string :env
      t.string :organization
      t.string :treasure
    end
  end

  def self.down
    drop_table :dragon_races
  end
end
