import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:lora_app/pages/finish_screen.dart';

import 'UIHelpers.dart';

class Game extends StatefulWidget {
  final List<String> playerNames;

  const Game({super.key, required this.playerNames});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  final List<int> points = List.generate(4, (index) => 0);
  final List<TextEditingController> controllers = List.generate(4, (_) => TextEditingController());
  final List<List<String>> options = List.generate(4, (_) => ["Max", "Min", "Kralj \u2665", "Sva \u2665\u2665", "Žandar \u2663", "Dame", "Lora"]);
  int currentPlayer = 0, selectedGame = -1;
  bool currentPhase = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelpers.buildGameAppBar('Game'),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          currentPhase ? gameChoosePhase() : pointsPhase(),

          SizedBox(height: 20),

          ...List.generate(widget.playerNames.length, (index) {
            return ListTile(
                title: Text("${widget.playerNames[index]}: ${points[index]}")
            );
          }),
        ],
      ),
    );
  }

  Card gameChoosePhase() {
    return Card(
        elevation: 3,
        child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${widget.playerNames[currentPlayer]}'s games: "),
                  SizedBox(height: 8),
                  Wrap(
                      spacing: 10,
                      children: List.generate(options[currentPlayer].length, (index) {
                        return ChoiceChip(
                          label: Text(options[currentPlayer][index]),
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
                                options[currentPlayer].removeAt(selectedGame);
                                currentPhase = !currentPhase;
                              });
                            },
                            child: Text("Confirm")
                        )
                      ]
                  )
                ]
            )
        )
    );
  }

  Card pointsPhase() {
    return Card(
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
                          if (currentPlayer == 3 && options[currentPlayer].length == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  FinishScreen(players: List.generate(4, (index) => MapEntry(
                                      widget.playerNames[index], points[index]))
                                  )
                              )
                            );
                          }
                          else {
                            selectedGame = -1;
                            currentPlayer = (currentPlayer + 1) % 4;
                            for (int i = 0; i < 4; i++) {
                              points[i] += int.parse(controllers[i].text);
                              controllers[i].clear();
                            }
                            currentPhase = !currentPhase;
                          }
                        });
                      },
                      child: Text("Confirm")
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.playerNames[index],
            ),

            TextField(
              controller: controllers[index],
              keyboardType: TextInputType.number,

            )
          ]
        )
      )
    );
  }
}
