import 'package:flutter/material.dart';

class UIHelpers {
  static AppBar buildGameAppBar(String title) {
    return AppBar(
      toolbarHeight: 35,
      title: Text(
          title,
          style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold
          )
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }

  static String get howToPlay =>
  """
  # Game Overview:
  - **Players**: 4
  - **Deck**: 32 cards (7, 8, 9, 10, J, Q, K of each suit)
  - **Rounds**: 28 rounds
  - **Objective**: Have least points at the end of the game.
  
  # Gameplay Flow:
  
  1. ## Dealing & Mini Game Selection:
  - Each round, every player is dealt 8 cards.
  - Current first player chooses a mini game (cannot choose a mini game already played by that player).
  
  2. ## Playing the Hands:
  - **Phase 1**: First player plays a card.
  - **Phase 2**: Other players play a card anticlockwise:
    - Must follow the suit of the first card if possible.
    - If they don’t have the suit, they can play any card.
  - **Phase 3**: Hand is taken by the player who played the highest card of the starting suit.
  - **Phase 4**: The player who won the previous hand starts the next one.
  - Repeat until all 8 hands are played.
  
  3. ## Scoring:
  - Points are given according to the mini game rules.
  
  4. ## Mini Games:
  - **Maximum**
     - Each hand taken: -1 point (you want more hands).
  - **Minimum**
     - Each hand taken: +1 point (you want fewer hands).
  - **King of Hearts & 6th Hand**
     - King of Hearts: +4 points
     - 6th hand played: +4 points
     - Goal: avoid both.
  - **Jack of Clubs**
     - Jack of Clubs: +8 points
     - Goal: avoid it, just... avoid it.
  - **Queens**
     - Each Queen: +2 points
     - Goal: avoid Queens.
  - **All Hearts**
     - Each Heart: +1 point
     - If you take all hearts, you get -8 points (high risk, high reward).
  - **Lora (special)**
     - Played differently from other mini games:
       1. First player places a card; this becomes the starting number for 4 piles (one per suit).
       2. Players must play a card if it can continue a pile (next in sequence).
       3. Game ends when a player gets rid of all cards:
          - That player: -8 points
          - Other players: +1 point for each card left in hand
  
  5. ## End of Game:
  - After each player plays all 7 mini games, total points are calculated.
  - Winner: player with least points.
  
  # Key Notes:
  - Players must follow suit if possible.
  - Strategy depends on which mini game is chosen.
  - Lora is the only mini game with a completely different mechanic, similar to solitaire.
  """;
}
