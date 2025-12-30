import 'package:flutter/material.dart';
import 'package:lora_app/pages/scaffold_custom.dart';
import 'package:lora_app/pages/ui_helpers.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';

class Rules extends StatelessWidget {
  const Rules({super.key});

  @override
  Widget build(BuildContext context) {
    final markdownStyle = MarkdownStyleSheet(
      p: GoogleFonts.openSans(fontSize: 16),
      strong: GoogleFonts.openSans(fontWeight: FontWeight.bold, fontSize: 16),
      em: GoogleFonts.openSans(fontStyle: FontStyle.italic, fontSize: 16),
      h1: GoogleFonts.openSans(fontSize: 22, fontWeight: FontWeight.bold),
      h2: GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.bold),
      h3: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.bold),
      listBullet: GoogleFonts.openSans(fontSize: 16),
      blockSpacing: 8,
      listIndent: 24,
    );

    return ScaffoldCustom(
      title: 'How to Play',
      body: ListView(
        children: UIHelpers.howToPlay.map((section) {
          final formattedText = "\n${section.text.trim()}";
          return ExpansionTile(
            title: Text(
              section.title,
              style: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            initiallyExpanded: false,
            children: [ 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: MarkdownBody(
                  data: formattedText,
                  styleSheet: markdownStyle,
                  selectable: true,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}



