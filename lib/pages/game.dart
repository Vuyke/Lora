import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lora_app/data_class/game_state.dart';
import 'package:lora_app/data_class/game_type.dart';
import 'package:lora_app/data_class/players.dart';
import 'package:lora_app/data_class/points.dart';
import 'package:lora_app/pages/finish_screen.dart';
import 'package:lora_app/pages/text_styles.dart';
import 'scaffold_custom.dart';

class Game extends StatefulWidget {
  final Players players;

  const Game({super.key, required this.players});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  final List<int> radioButtonValues = List.filled(4, 0);
  final List<int> signButtonValues = List.filled(4, 1);
  // final List<List<GameType>> options = List.generate(4, (_) => List<GameType>.of(GameType.gameTypes));
  final List<List<GameType>> options = List.generate(4, (_) => [GameType.gameTypes[0]]);
  late final GameState state = GameState(gameCount: options[0].length, players: widget.players);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      title: 'Game',
      body:
      ListView(
        padding: EdgeInsets.all(12),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MarkdownBody(
                      data: "**Round**: ${state.currentRound} of ${state.totalRounds}",
                      styleSheet: AppStyle.markdownStyle
                    ),
                  ],
                ),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              state.getPhase() ? gameChoosePhase() : pointsPhase(),
              Visibility(
                visible: state.errorMessage.isNotEmpty,
                child: Padding(
                  padding: EdgeInsetsGeometry.all(10),
                  child: Text(
                    state.errorMessage,
                    style: AppStyle.errorMessageStyle,
                  ),
                ),
              )
            ]
          ),

          SizedBox(height: 20),

          CheckboxListTile(
            title: Text(
              state.showResults ? "Hide Results" : "Show Results",
              style: AppStyle.normalTextStyle,
            ),
            value: state.showResults,
            onChanged: (value) {
              setState(() {
                state.showResults = value ?? false;
              });
            }
          ),

          Visibility(
            visible: state.showResults,
            child: Column(
              children: [
                Card(
                  child: Column (
                    children: [...List.generate(widget.players.length, (index) {
                      return ListTile(
                        title: MarkdownBody(
                          data: "**${widget.players[index]}**: ${state.stats.totalPoints[index]}",
                          styleSheet: AppStyle.markdownStyle
                          )
                        );  
                      }),
                    ]
                  ) 
                ),
                SizedBox(height: 40)
              ],
            ), 
          )
        ],
      ),
    );
  }

  Widget gameChoosePhase() {
    return Card(
      elevation: 3,
      child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.players[state.currentPlayer]}'s games: ",
                  style: AppStyle.normalTextStyle,
                  ),
                Text(
                  "Select a game to play:",
                  style: AppStyle.subtitleStyle,
                  ),
                SizedBox(height: 20),
                Wrap(
                    spacing: 5,
                    children: List.generate(options[state.currentPlayer].length, (index) {
                      return ChoiceChip(
                        label: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Text(
                            options[state.currentPlayer][index].name,
                            style: AppStyle.normalTextStyle
                            ),
                        ),
                        selected: state.game == options[state.currentPlayer][index],
                        onSelected: (selected) {
                          setState(() {
                            state.game = options[state.currentPlayer][index];
                          });
                        },
                      );
                    })
                ),

                SizedBox(height: 20),

                Row(
                    children: [
                      Spacer(),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              state.errorMessage = "";
                              if (state.game == GameType.none){
                                state.errorMessage = "Error: no game selected";
                                return;
                              }
                              else {
                                options[state.currentPlayer].remove(state.game);
                                state.changePhase();
                              }
                            });
                          },
                          child: Text(
                            "Confirm",
                            style: AppStyle.buttonStyle
                            )
                      )
                    ]
                )
              ]
          )
      )
    );
  }

  Widget pointsPhase() {
    return Card(
      elevation: 3,
      child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MarkdownBody(
                data: "Player **${widget.players[state.currentPlayer]}** selected game: **${state.game.name}**",
                styleSheet: AppStyle.markdownStyle
              ),
              SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: List.generate(4, (index) =>
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: pointsPhaseOnePlayer(index),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 8),

              Row(
                children: [
                  Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Points points = Points.empty();
                          for (int i = 0; i < 4; i++) {
                            points[i] = radioButtonValues[i] * signButtonValues[i];
                          }
                          if(state.finishRound(points)) {
                            refreshButtonValues();
                            if (state.isGameFinished()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      FinishScreen(state: state)
                                  )
                              );
                            }
                          }
                        });
                      },
                      child: Text(
                        "Confirm",
                        style: AppStyle.buttonStyle
                      )
                  )
                ]
              )
            ],
          )
      )
    );
  }

 Widget pointsPhaseOnePlayer(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.players[index].toString(),
                style: AppStyle.buttonStyle
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {signButtonValues[index] *= -1;});
                    },
                    child: Text(signButtonValues[index] > 0 ? "+" : "-", style: AppStyle.buttonStyle)
                  ),
                  SizedBox(width: 8),
                  Expanded(child:dropDownMenu(index))
                ],
              )
          ],
        )
      )
    );
  }

  Widget dropDownMenu(int index) {
    return DropdownButtonFormField<int>(
      initialValue: 0,
      items: List.generate(9, (value) => DropdownMenuItem<int>(
        value: value,
        child: Text(value.toString()),
      )),
      onChanged: (value) {
        setState(() {
          radioButtonValues[index] = value ?? 0;
        });
      },
    );
  }

  void refreshButtonValues() {
    for(int i = 0; i < 4; i++) {
      radioButtonValues[i] = 0;
      signButtonValues[i] = 1;
    }
  }
}
