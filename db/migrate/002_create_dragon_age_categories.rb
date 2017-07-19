class CreateDragonAgeCategories < ActiveRecord::Migration[4.2]
  def self.up
    create_table :dragon_age_categories do |t|
      t.string :age_category
      t.string :age_in_years
      t.integer :cr
      t.integer :size
      t.integer :hit_dice
      t.integer :natural_armor
      t.integer :breath
      t.integer :str
      t.integer :dex
      t.integer :con
      t.integer :int
      t.integer :wis
      t.integer :chr
    end
  end

  def self.down
    drop_table :dragon_age_categories
  end
end
