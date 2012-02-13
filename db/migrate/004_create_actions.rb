class CreateActions < ActiveRecord::Migration
  def self.up
    create_table :actions do |t|
      t.integer :game_id
      t.string :betting_round
      t.integer :turn_number
      t.string :action
      t.integer :amount
      t.integer :player_id
    end
  end

  def self.down
    drop_table :actions
  end
end
