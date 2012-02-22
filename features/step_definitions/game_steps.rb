Given /I have a fresh game table/ do
  @game_table = Factory.create :game_table

  @seq = sequence('turn sequence')
end

When /the hand begins/ do
  @hand = @game_table.hands.create

  # Workaround to preserve expectations.
  Hand.any_instance.stubs(:active_players).returns(@players.values)
end

Given /a player named (\w+) with (\d+) chips/ do |name, chips|
  @players ||= {}
  @players[name] = @game_table.tournament.players.create(:name => name, :chips => chips)
  @game_table.seatings.create(:player => @players[name])
end

When /(\w+) bets (\d+)/ do |name, chips|
  @players[name].expects(:get_action).in_sequence(@seq).returns(
    :action => "bet",
    :amount => chips
  )
end

When /(\w+) folds/ do |name|
  @players[name].expects(:get_action).in_sequence(@seq).returns(
    :action => "fold"
  )
end

When /(\w+) posts blinds of (\d+)/ do |name, chips|
  @players[name].expects(:get_action).in_sequence(@seq).returns({
    :action => "blind",
    :amount => chips
  })
end

When /(\w+) fails to post blinds/ do |name|
  @players[name].expects(:blind).in_sequence(@seq).returns(false)
end

When /the hand plays out/ do
  @hand.play!
end

# This will end the scenario!
Then /the round should advance to (\w+)/ do |round|
  @hand.expects(:next_turn).in_sequence(@seq)
end

Then /^the hand should have (\d+) community cards$/ do |card_count|
    @hand.community_cards.size.should == card_count.to_i
end

Then /^each player should have (\d+) pocket cards$/ do |card_count|
    @players.each do |name, player|
      player.cards.where(:hand_id => @hand).size.should == card_count.to_i
    end
end

Then /^the hand should have community and pocket cards$/ do
    @hand.cards.size.should == (@players.size * 2) + 5
end

# This will end the scenario!
Then /the round should be over/ do
  @hand.expects(:close_hand!).in_sequence(@seq)
end
