import 'package:flutter/material.dart';
import 'package:lora_app/pages/scaffold_custom.dart';
import 'package:lora_app/pages/game.dart';
import 'package:lora_app/pages/text_styles.dart';

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
    return ScaffoldCustom(
      title: 'Add Players',
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.black12,
              child: Icon( 
                Icons.person_add,
                size: 70,
                color: Colors.black38,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Enter player names:',
                style: AppStyle.titleStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Add names for all 4 players.',
                style: AppStyle.normalTextStyle,
              ),
            ),
            Expanded(
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
                          style: AppStyle.normalTextStyle,
                          decoration: InputDecoration(
                            labelText: 'Player ${i + 1}',
                            errorStyle: AppStyle.errorMessageStyle,
                            border: const OutlineInputBorder(),
                            labelStyle: AppStyle.labelStyle,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2
                              ),
                            ),
                            floatingLabelStyle: AppStyle.floatingLabelStyle,
                            
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'This field is required.';
                            }
                            return null;
                          },
                        ),
                      ),
                            
                    const SizedBox(height: 25),
                            
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
                          style: AppStyle.buttonStyle
                      ), 
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
