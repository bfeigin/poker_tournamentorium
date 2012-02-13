class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.integer :tournament_id
      t.string :betting_round
      t.integer :turn
      t.integer :action_to
    end
  end

  def self.down
    drop_table :games
  end
end
