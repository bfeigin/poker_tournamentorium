class CreateHands < ActiveRecord::Migration
  def self.up
    create_table :hands do |t|
      t.integer :player_id
      t.string :cards
      t.integer :turn_number
    end
  end

  def self.down
    drop_table :hands
  end
end
