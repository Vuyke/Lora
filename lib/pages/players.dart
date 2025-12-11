import 'package:flutter/material.dart';
import 'package:lora_app/pages/UIHelpers.dart';
import 'package:lora_app/pages/game.dart';

class Players extends StatefulWidget {
  const Players({super.key});

  @override
  State<Players> createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
  final List<TextEditingController> playerControllers =
    List.generate(4, (_) => TextEditingController());

  @override
  void dispose() {
    for (var controller in playerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelpers.buildGameAppBar('Add Players'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Generate 4 text fields automatically
            for (int i = 0; i < playerControllers.length; i++)
              TextField(
                controller: playerControllers[i],
                decoration: InputDecoration(
                  labelText: "Player ${i + 1}",
                ),
              ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                List<String> names = playerControllers.map((c) => c.text).toList();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Game(playerNames: names))
                );
              },
              child: Text("Start Game"),
            ),
          ],
        ),
      ),
    );
  }
}
