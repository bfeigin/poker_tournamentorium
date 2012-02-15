class CreateSeatings < ActiveRecord::Migration
  def self.up
    create_table :seatings do |t|
      t.integer :player_id
      t.integer :game_id
      t.integer :seat_number
      t.boolean :active
    end
  end

  def self.down
    drop_table :seatings
  end
end
