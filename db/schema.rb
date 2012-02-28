# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 9) do

  create_table "accounts", :force => true do |t|
    t.string "name"
    t.string "surname"
    t.string "email"
    t.string "crypted_password"
    t.string "role"
  end

  create_table "actions", :force => true do |t|
    t.integer "round_id"
    t.integer "player_id"
    t.string  "action_name"
    t.integer "amount"
  end

  create_table "cards", :force => true do |t|
    t.string  "value_code",    :null => false
    t.string  "suit_code",     :null => false
    t.string  "label"
    t.integer "dealable_id",   :null => false
    t.string  "dealable_type", :null => false
    t.integer "hand_id",       :null => false
  end

  add_index "cards", ["value_code", "suit_code", "hand_id"], :name => "non_duplicate_cards_per_hand", :unique => true

  create_table "game_tables", :force => true do |t|
    t.integer "tournament_id"
    t.integer "hands_played"
    t.integer "dealer_id"
    t.string  "game_type",     :default => "texas_holdem", :null => false
  end

  create_table "hand_start_stats", :force => true do |t|
    t.integer "hand_id"
    t.integer "player_id"
    t.integer "chips"
  end

  create_table "hands", :force => true do |t|
    t.integer "game_table_id"
    t.string  "community_cards"
    t.boolean "active",          :default => false, :null => false
  end

  create_table "players", :force => true do |t|
    t.integer "tournament_id"
    t.string  "hostname"
    t.integer "chips",         :default => 0, :null => false
    t.string  "name"
  end

  create_table "rounds", :force => true do |t|
    t.integer "hand_id"
    t.string  "betting_phase"
    t.boolean "open",          :default => true, :null => false
    t.integer "pot",           :default => 0
  end

  create_table "seatings", :force => true do |t|
    t.integer "player_id"
    t.integer "game_table_id"
    t.integer "seat_number"
    t.boolean "active",        :default => true, :null => false
  end

  create_table "tournaments", :force => true do |t|
    t.string "name"
  end

end
