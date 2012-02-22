Feature: Texas Hold'Em
  In order to run a poker tournament
  I want the server to correctly handle gameplay

  Scenario: A one-hand game with simple betting
    Given I have a fresh game table
    And a player named Alice with 100 chips
    And a player named Bob with 100 chips
    When the hand begins
    When Alice posts blinds
    And Bob posts blinds
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
