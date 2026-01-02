import 'package:flutter/material.dart';
import 'package:lora_app/pages/scaffold_custom.dart';
import 'package:lora_app/pages/text_styles.dart';
import 'package:lora_app/pages/ui_helpers.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Rules extends StatelessWidget {
  const Rules({super.key});

  @override
  Widget build(BuildContext context) {
    
    return ScaffoldCustom(
      title: 'How to Play',
      body: ListView(
        children: UIHelpers.howToPlay.map((section) {
          final formattedText = "\n${section.text.trim()}";
          return ExpansionTile(
            title: Text(
              section.title,
              style: AppStyle.normalTextStyle
            ),
            initiallyExpanded: false,
            children: [ 
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: MarkdownBody(
                  data: formattedText,
                  styleSheet: AppStyle.markdownStyle,
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



