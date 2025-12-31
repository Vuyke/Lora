import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lora_app/pages/players.dart';

import 'scaffold_custom.dart';

class FinishScreen extends StatelessWidget {
  final List<MapEntry<String, int>> players;

  const FinishScreen({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    return ScaffoldCustom(
      title: "Game finished",
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Winner is: ${winner()}",
              style: GoogleFonts.openSans(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)
              ),

            SizedBox(height: 8),

            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Players()));
                },
                child: Text(
                  "Play again",
                  style: GoogleFonts.openSans(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)
                  )
            ),

            SizedBox(height: 8),

            ElevatedButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text(
                  "Exit",
                  style: GoogleFonts.openSans(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)
                  )
            )
          ]
        )
      )
    );
  }

  String winner() {
    return players.reduce((a, b) => a.value < b.value ? a : b).key;
  }
}
