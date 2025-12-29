import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lora_app/pages/UIHelpers.dart';
import 'package:lora_app/pages/game.dart';

class Players extends StatefulWidget {
  const Players({super.key});

  @override
  State<Players> createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
  final _formKey = GlobalKey<FormState>();

  final List<TextEditingController> playerControllers =
      List.generate(4, (_) => TextEditingController());

  @override
  void dispose() {
    for (final controller in playerControllers) {
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              for (int i = 0; i < playerControllers.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 5),
                  child: TextFormField(
                    controller: playerControllers[i],
                    cursorColor: Colors.black,
                    style: GoogleFonts.openSans(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                      labelText: 'Player ${i + 1}',
                      errorStyle: GoogleFonts.openSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      border: const OutlineInputBorder(),
                      labelStyle: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.bold),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2
                        ),
                      ),
                      floatingLabelStyle: GoogleFonts.openSans(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),

                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required.';
                      }
                      return null;
                    },
                  ),
                ),

              const SizedBox(height: 50),

              ElevatedButton(
                onPressed: () {
                  final isValid =
                      _formKey.currentState!.validate();

                  if (!isValid) return;

                  final names = playerControllers
                      .map((c) => c.text.trim())
                      .toList();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Game(playerNames: names),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  )
                ),
                child: Text(
                    'Start Game', 
                    style: GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)
                ), 
              ),
            ],
          ),
        ),
      ),
    );
  }
}
