import 'package:flutter/material.dart';
import 'package:lora_app/pages/UIHelpers.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';

class Rules extends StatelessWidget {
  const Rules({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelpers.buildGameAppBar("How to play"),
      body: Padding(
        padding: EdgeInsets.all(6),
        child: Markdown(
          data: UIHelpers.howToPlay,
          styleSheet: MarkdownStyleSheet(
            p: GoogleFonts.openSans(fontSize: 14),
            strong: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.bold)
          ),
        )
      ),
    );
  }
}
