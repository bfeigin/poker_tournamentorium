class CreateTournaments < ActiveRecord::Migration
  def self.up
    create_table :tournaments do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :tournaments
  end
end
