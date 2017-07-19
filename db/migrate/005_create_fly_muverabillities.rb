class CreateFlyMuverabillities < ActiveRecord::Migration[4.2]
  def self.up
    create_table :fly_muverabillities do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :fly_muverabillities
  end
end
