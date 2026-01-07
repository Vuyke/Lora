import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lora_app/data_class/game_statistics.dart';
import 'package:lora_app/data_class/game_type.dart';
import 'package:lora_app/data_class/players.dart';
import 'package:lora_app/data_class/points.dart';
import 'package:lora_app/data_class/round_statistics.dart';
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
  late final GameStatistics stats;
  final List<TextEditingController> controllers = List.generate(4, (_) => TextEditingController());
  // final List<List<GameType>> options = List.generate(4, (_) => List<GameType>.of(GameType.gameTypes));
  final List<List<GameType>> options = List.generate(4, (_) => [GameType.gameTypes[0]]);
  int currentPlayer = 0, currentRound = 1, totalRounds = 0;
  GameType selectedGame = GameType.none;
  bool currentPhase = true, errorOccurred = false, showResults = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    stats = GameStatistics(players: widget.players);
    totalRounds = options.length * options[0].length;
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
                      data: "**Round**: $currentRound of $totalRounds",
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
              currentPhase ? gameChoosePhase() : pointsPhase(),
              Visibility(
                visible: errorOccurred,
                child: Padding(
                  padding: EdgeInsetsGeometry.all(10),
                  child: Text(
                    errorMessage,
                    style: AppStyle.errorMessageStyle,
                  ),
                ),
              )
            ]
          ),

          SizedBox(height: 20),

          CheckboxListTile(
            title: Text(
              showResults ? "Hide Results" : "Show Results",
              style: AppStyle.normalTextStyle,
            ),
            value: showResults,
            onChanged: (value) {
              setState(() {
                showResults = value ?? false;
              });
            }
          ),

          Visibility(
            visible: showResults,
            child: Column(
              children: [
                Card(
                  child: Column (
                    children: [...List.generate(widget.players.length, (index) {
                      return ListTile(
                        title: MarkdownBody(
                          data: "**${widget.players[index]}**: ${stats.totalPoints[index]}",
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
                  "${widget.players[currentPlayer]}'s games: ",
                  style: AppStyle.normalTextStyle,
                  ),
                Text(
                  "Select a game to play:",
                  style: AppStyle.subtitleStyle,
                  ),
                SizedBox(height: 20),
                Wrap(
                    spacing: 5,
                    children: List.generate(options[currentPlayer].length, (index) {
                      return ChoiceChip(
                        label: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Text(
                            options[currentPlayer][index].name,
                            style: AppStyle.normalTextStyle
                            ),
                        ),
                        selected: selectedGame == options[currentPlayer][index],
                        onSelected: (selected) {
                          setState(() {
                            selectedGame = options[currentPlayer][index];
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
                              errorOccurred = false;
                              if (selectedGame == GameType.none){
                                errorMessage = "Error: no game selected";
                                errorOccurred = true;
                              }
                              else {
                                options[currentPlayer].remove(selectedGame);
                                currentPhase = !currentPhase;
                              }

                              if (errorOccurred) return;
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
                data: "Player **${widget.players[currentPlayer]}** selected game: **${selectedGame.name}**",
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
                          errorOccurred = false;
                          Points newPoints = Points.empty();
                          for (int i = 0; i < 4; i++) {
                            int? tmp = int.tryParse(controllers[i].text);
                            if (controllers[i].text.isEmpty) {
                              tmp = 0;
                            }
                            if (tmp == null) {
                              errorMessage = "Error: values must be digits";
                              errorOccurred = true;
                            }
                            else {
                              newPoints[i] = tmp;
                            }
                          }
                          if (errorOccurred) return;

                          if (!newPoints.checkGameRulesApply(selectedGame)) {
                            errorMessage = "Error: points not given properly";
                            errorOccurred = true;
                            return;
                          }
                          RoundStatistics roundStatistics =
                            RoundStatistics(id: selectedGame, points: newPoints, players: stats.players);
                          stats.addRoundStatistics(roundStatistics);
                          selectedGame = GameType.none;
                          currentPlayer = (currentPlayer + 1) % 4;
                          currentPhase = !currentPhase;
                          currentRound += 1;
                          if (currentPlayer == 0 && options[currentPlayer].isEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                FinishScreen(stats: stats)
                              )
                            );
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

  Card pointsPhaseOnePlayer(int index) {
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
              TextField(
                controller: controllers[index],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "0"),
            )
          ],
        )
      )
    );
  }
}

