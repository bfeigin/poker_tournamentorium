Feature: Betting rounds
  In order to allow players to strategically bet on hands
  I want a hand to have four betting rounds
  Which follow the rules of betting and observe blinds

  Scenario: A one-hand game with simple betting
    Given I have a fresh game table
    And a player named Alice with 100 chips
    And a player named Bob with 100 chips
    When the hand begins
    When Alice posts blinds of 1
    And Bob posts blinds of 2
    And Alice bets 10
    And Bob bets 10
    #Then the round should advance to flop
    When Alice bets 5
    And Bob bets 10
    And Alice bets 10
    #Then the round should advance to turn
    When Bob bets 5
    And Alice bets 10
    And Bob bets 15
    And Alice bets 15
    #Then the round should advance to river
    When Bob bets 10
    And Alice folds
    Then the round should be over
    When the hand plays out
    Then the hand should have 5 community cards
    Then each player should have 2 pocket cards
    Then the hand should have community and pocket cards

