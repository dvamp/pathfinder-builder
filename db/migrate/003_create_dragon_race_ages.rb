class CreateDragonRaceAges < ActiveRecord::Migration[4.2]
  def self.up
    create_table :dragon_race_ages do |t|
      t.integer :race_id
      t.integer :age_id
      t.text :sense
      t.text :aura
      t.text :defensive_ability
      t.string :dr
      t.integer :sr
      t.text :additional_move
      t.text :special_attack
      t.text :sp
      t.integer :caster_level
      t.string :caster_source
      t.text :sq
    end
  end

  def self.down
    drop_table :dragon_race_ages
  end
end
