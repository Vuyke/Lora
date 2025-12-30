import 'package:flutter/material.dart';
import 'package:lora_app/pages/ui_helpers.dart';

class ScaffoldCustom extends StatelessWidget {
  final String title;
  final Widget body;
  const ScaffoldCustom({required this.title, required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelpers.buildGameAppBar(title),
      body: body
    );
  }
}
