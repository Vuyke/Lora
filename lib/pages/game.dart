import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lora_app/pages/finish_screen.dart';
import 'package:lora_app/pages/text_styles.dart';
import 'scaffold_custom.dart';

class Game extends StatefulWidget {
  final List<String> playerNames;

  const Game({super.key, required this.playerNames});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  final List<int> points = [0, 0, 0, 0];
  final List<TextEditingController> controllers = List.generate(4, (_) => TextEditingController());
  final List<List<String>> options = List.generate(4, (_) => ["Max", "Min", "Kralj \u2665", "Sva \u2665\u2665", "Žandar \u2663", "Dame", "Lora"]);
  int currentPlayer = 0, selectedGame = -1, currentRound = 1;
  bool currentPhase = true, errorOccurred = false, showResults = false;
  String errorMessage = "";

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
            child: MarkdownBody(
              data: "**Round**: $currentRound",
              styleSheet: AppStyle.markdownStyle
            ),
          ),
          
          currentPhase ? gameChoosePhase() : pointsPhase(),

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
            child: Card(
              child:Column (
                children: [...List.generate(widget.playerNames.length, (index) {
                  return ListTile(
                    title: MarkdownBody(
                      data: "**${widget.playerNames[index]}**: ${points[index]}",
                      styleSheet: AppStyle.markdownStyle
                      )
                    );  
                  }),
                ]
              ) 
            ), 
          )
        ],
      ),
    );
  }


  Widget gameChoosePhase() {
    return Column (
      children: [
        Card(
            elevation: 3,
            child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${widget.playerNames[currentPlayer]}'s games: ",
                        style: AppStyle.normalTextStyle,
                        ),
                      SizedBox(height: 8),
                      Wrap(
                          spacing: 10,
                          children: List.generate(options[currentPlayer].length, (index) {
                            return ChoiceChip(
                              label: Text(
                                options[currentPlayer][index],
                                style: AppStyle.normalTextStyle
                                ),
                              selected: selectedGame == index,
                              onSelected: (selected) {
                                setState(() {
                                  selectedGame = index;
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
                                    if (selectedGame == -1){
                                      errorMessage = "Error: no game selected";
                                      errorOccurred = true;
                                    }
                                    else {
                                    options[currentPlayer].removeAt(selectedGame);
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
        ),
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
      ],
    );
  }

  Widget pointsPhase() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          elevation: 3,
          child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(4, (index) =>
                          SizedBox(
                            width: 50,
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
                              List<int> newPoints = [0, 0, 0, 0];
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
                                controllers[i].clear();
                              }
                              if (errorOccurred) return;

                              if (!_checkGameRulesApply(newPoints)) {
                                errorMessage = "Error: points not given properly";
                                errorOccurred = true;
                                return;
                              }
                              for(int i = 0; i < 4; i++) {
                                points[i] += newPoints[i];
                              }
                              selectedGame = -1;
                              currentPlayer = (currentPlayer + 1) % 4;
                              currentPhase = !currentPhase;
                              currentRound += 1;
                              if (currentPlayer == 0 && options[currentPlayer].isEmpty) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        FinishScreen(players: List.generate(4, (index) => MapEntry(
                                            widget.playerNames[index], points[index]))
                                        )
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
        ),
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
    );
  }

  Card pointsPhaseOnePlayer(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.playerNames[index],
              style: GoogleFonts.openSans(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)
            ),

            TextField(
              controller: controllers[index],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "0", hintStyle: GoogleFonts.openSans(fontWeight: FontWeight.normal)),
            )
          ]
        )
      )
    );
  }

  bool _checkGameRulesApply(List<int> newPoints) {
    int sum = newPoints.reduce((a, b) => a + b);
    List<int> tmpPoints = List<int>.from(newPoints);
    tmpPoints.sort((a, b) => a - b);
    switch(selectedGame) {
      case 0:
        return _negative8(tmpPoints, sum);
      case 1:
        return _positive8(tmpPoints, sum);
      case 2:
        return _positive8(tmpPoints, sum) && _allDivisibleBy(tmpPoints, 4);
      case 3:
        return (_positive8(tmpPoints, sum) && tmpPoints[3] < 8) || (_negative8(tmpPoints, sum) && tmpPoints[0] == -8);
      case 4:
        return _positive8(tmpPoints, sum) && tmpPoints[3] == 8;
      case 5:
        return _positive8(tmpPoints, sum) && _allDivisibleBy(tmpPoints, 2);
      case 6:
        return tmpPoints[0] == -8 && tmpPoints[1] > 0 && tmpPoints[3] <= 8;
      default:
        return true;
    }
  }

  bool _allDivisibleBy(List<int> newPoints, int div) {
    return newPoints.map((x) => x % div == 0).reduce((x, y) => x && y);
  }

  bool _positive8(List<int> newPoints, int sum) {
    return sum == 8 && newPoints[0] >= 0;
  }
  
  bool _negative8(List<int> newPoints, int sum) {
    return sum == -8 && newPoints[3] <= 0;
  }
}

