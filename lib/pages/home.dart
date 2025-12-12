import 'package:flutter/material.dart';
import 'package:lora_app/pages/UIHelpers.dart';
import 'package:lora_app/pages/how_to_play.dart';
import 'package:lora_app/pages/players.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelpers.buildGameAppBar('Lora app'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            button(Players(), context, 'Start game'),
            SizedBox(height: 80),
            button(Rules(), context, 'How to Play'),
          ]
        )
      )
    );
  }

  ElevatedButton button(Widget w, BuildContext context, String name) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => w)
        );
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        )
      ),
      child: Text(
        name,
        style: TextStyle(fontSize: 20)
      )
    );
  }
}
