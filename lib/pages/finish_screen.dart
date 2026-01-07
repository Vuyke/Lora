import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lora_app/data_class/game_statistics.dart';
import 'package:lora_app/pages/players_names_page.dart';
import 'package:lora_app/pages/text_styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data_class/player.dart';
import 'scaffold_custom.dart';

class FinishScreen extends StatelessWidget {
  final GameStatistics stats;
  final List<MapEntry<Player, int>> players;

  FinishScreen({super.key, required this.stats})
    : players = stats.playerResults();

  @override
  Widget build(BuildContext context) {
    Map <String, int> placements = getPlacements();
    return ScaffoldCustom(
      title: "Game finished",
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.black,
                child: FaIcon(
                  FontAwesomeIcons.trophy,
                  size: 100,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              "Game Completed!",
              style: AppStyle.titleStyle
              ),
            SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.trophy,
                          color: Colors.yellow,
                          size: 30,
                        ),
                        Text(
                          " ${placements.entries.first.key} wins!",
                          style: AppStyle.winnerTextStyle
                        ),
                      ],
                    ),
                    Text(
                      "with ${placements.entries.first.value} points!",
                      style: AppStyle.winnerSubTextStyle
                    )
                  ],
                ),
              ),
            ),

            SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text (
                "Final Standings:",
                style: AppStyle.normalTextStyle
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "2nd Place:",
                        style: AppStyle.subtitleStyle
                      ),
                      Text(
                        placements.entries.elementAt(1).key,
                      ),
                       Text(
                        "${placements.entries.elementAt(1).value} pts",
                        style: AppStyle.normalTextStyle
                      ),
                      ClipRRect(
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.zero, 
                            ),
                            color: Colors.blueGrey,
                          ),
                          child: Center(
                            child: Text(
                              "2",
                              style: AppStyle.winnerTextStyle
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "1st Place:",
                        style: AppStyle.subtitleStyle
                      ),
                      Text(
                        placements.entries.first.key,
                      ),
                       Text(
                        "${placements.entries.first.value} pts",
                        style: AppStyle.normalTextStyle
                      ),
                      ClipRRect(
                        child: Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.zero, 
                            ),
                            color: Colors.black,
                          ),
                          child: Center(
                            child: Text(
                              "1",
                              style: AppStyle.winnerTextStyle
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "3rd Place:",
                        style: AppStyle.subtitleStyle
                      ),
                      Text(
                        placements.entries.elementAt(2).key,
                      ),
                       Text(
                        "${placements.entries.elementAt(2).value} pts",
                        style: AppStyle.normalTextStyle
                      ),
                      ClipRRect(
                        child: Container(
                          height: 75,
                          width:  MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.zero, 
                            ),
                            color: Colors.grey,
                          ),
                          child: Center(
                            child: Text(
                              "3",
                              style: AppStyle.winnerTextStyle
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[300],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: MediaQuery.of(context).size.width * 0.1,
                children: [
                  Row(
                    children: [
                    Text(
                      "4th Place: ",
                      style: AppStyle.subtitleStyle
                    ),
                    Text(
                      placements.entries.elementAt(3).key,
                      style: AppStyle.normalTextStyle
                    ),
                  ],
                ), 
                    Text(
                    "${placements.entries.elementAt(3).value} pts",
                    style: AppStyle.normalTextStyle
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PlayersNamesPage()));
                },
                child: Text(
                  "Play again",
                  style: AppStyle.buttonStyle
                  )
            ),

            SizedBox(height: 8),

            ElevatedButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text(
                  "Exit",
                  style: AppStyle.buttonStyle
                  )
            )
          ]
        )
      )
    );
  }

  Map<String, int> getPlacements() {
    players.sort((a, b) => a.value - b.value);
    final Map<String, int> placementMap= {};

    for (final player in players) {
      placementMap[player.key.name] = player.value;
    } 

    return placementMap;
  }

}

  