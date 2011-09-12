class CreateSizeCategories < ActiveRecord::Migration
  def self.up
    create_table :size_categories do |t|
      t.integer :size_id
      t.string :name
      t.string :pose
      t.integer :ba_size_modifer
      t.integer :cmb_size_modifer
      t.string :space
      t.string :reach
      t.string :bite_reach
      t.string :fly_speed
      t.string :fly_muverabillity
      t.string :bite_damage
      t.string :claws_damage
      t.string :wings_damage
      t.string :tail_slap_damage
      t.string :crush_damage
      t.string :tail_sweep_damage
      t.string :breath_range_line
      t.string :breath_range_cone
    end
  end

  def self.down
    drop_table :size_categories
  end
end
