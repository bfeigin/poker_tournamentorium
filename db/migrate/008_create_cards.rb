class CreateCards < ActiveRecord::Migration
  def self.up
    create_table :cards do |t|
      t.string :value
      t.string :suit
      t.integer :player_id
      t.integer :hand_id
    end
  end

  def self.down
    drop_table :cards
  end
end
