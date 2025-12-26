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
        padding: EdgeInsets.only(bottom: 30),
        child: Markdown(
          data: UIHelpers.howToPlay,
          styleSheet: MarkdownStyleSheet(
            p: GoogleFonts.openSans(fontSize: 16),
            strong: GoogleFonts.openSans(fontWeight: FontWeight.bold),
            h1: GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.bold),
            h2: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.bold)
          ),
        )
      ),
    );
  }
}
