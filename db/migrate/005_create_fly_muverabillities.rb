class CreateFlyMuverabillities < ActiveRecord::Migration
  def self.up
    create_table :fly_muverabillities do |t|
      t.integer :id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :fly_muverabillities
  end
end
