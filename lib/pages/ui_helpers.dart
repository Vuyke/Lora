import 'package:flutter/material.dart';
import 'package:lora_app/pages/rule_section.dart';
import 'package:lora_app/pages/text_styles.dart';

class UIHelpers {
  static AppBar buildGameAppBar(String title) {
    return AppBar(
      toolbarHeight: 45,
      title: Text(
          title,
          style: AppStyle.buttonStyle
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }


  static List<RuleSection> howToPlay = [
    RuleSection(
      title: "Game Overview",
      text: 
      """

- **Players**: 4  
- **Deck**: 32 cards (7, 8, 9, 10, J, Q, K of each suit)  
- **Rounds**: 7 mini games × 4 players  
- **Objective**: Have the fewest points at the end of the game.  

""",
    ),
    RuleSection(
      title: "Dealing & Mini Game Selection",
      text: 
      """

- Each round, every player is dealt 8 cards.  
- The current first player chooses a mini game.  
- A player cannot choose a mini game they already played.  

      """,
    ),
    RuleSection(
      title: "Playing Hands",
      text: 
      """

- First player plays a card.  
- Other players play anticlockwise.  
- Players must follow the starting suit if possible.  
- If unable to follow suit, any card may be played.  
- The highest card of the starting suit wins the hand.  
- The winner starts the next hand.  
- Repeat until all 8 hands are played.  

      """,
    ),
     RuleSection(
      title: "Scoring",
      text: 
      """

- Points are assigned according to the chosen mini game.    

      """,
    ),
    RuleSection(
      title: "Mini Games",
      text: 
      """
  ### Maximum  
  - Each hand taken: **-1 point**  
  - Goal: take as many hands as possible.  

  ### Minimum  
  - Each hand taken: **+1 point**  
  - Goal: take as few hands as possible.  

  ### King of Hearts & 6th Hand  
  - King of Hearts: **+4 points**  
  - 6th hand taken: **+4 points**  
  - Goal: avoid both.  

  ### Jack of Clubs  
  - Jack of Clubs: **+8 points**  
  - Goal: avoid it at all costs.  

  ### Queens  
  - Each Queen: **+2 points**  
  - Goal: avoid Queens.  

  ### All Hearts  
  - Each Heart: **+1 point**  
  - If you take all Hearts: **-8 points**  
 
  ###  Lora (Special Mini Game)  
  - Uses a completely different mechanic.  
  - First player places a card to start all suit piles.  
  - Players must play a card if it continues a pile sequence.  
  - Game ends when a player has no cards left.
  **Scoring**  
  - Player who finishes first: **-8 points**  
  - Other players: **+1 point per card left**    
      """,
    ),
  RuleSection(
    title: "End of Game",
    text: 
      """

- After all players have played all 7 mini games, points are summed.  
- The player with the fewest points wins.   

      """,
    ),
  ];
}