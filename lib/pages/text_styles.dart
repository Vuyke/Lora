import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle{
  static TextStyle normalTextStyle = GoogleFonts.openSans(
    color: Colors.black,
    fontSize: 18
  );

  static TextStyle buttonStyle = GoogleFonts.openSans(
    color: Colors.black,
    fontSize: 18, 
    fontWeight: FontWeight.bold
  );

  static TextStyle floatingLabelStyle = GoogleFonts.openSans(
    color: Colors.black, 
    fontSize: 18, 
    fontWeight: FontWeight.w500
  );

  static TextStyle errorMessageStyle = GoogleFonts.openSans(
    color: Colors.red, 
    fontSize: 10, 
    fontWeight: FontWeight.bold
  );

  static TextStyle labelStyle = GoogleFonts.openSans(
    fontSize: 18, 
    fontWeight: 
    FontWeight.bold
  );

  static TextStyle titleStyle = GoogleFonts.openSans(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold
  );

  static TextStyle subtitleStyle = GoogleFonts.openSans(
    color: Colors.black38,
    fontSize: 15,
    fontWeight: FontWeight.w600
  );

  static TextStyle winnerTextStyle = GoogleFonts.openSans(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold
  );

  static TextStyle winnerSubTextStyle = GoogleFonts.openSans(
    color: Colors.grey,
    fontSize: 16,
  );

  static final markdownStyle = MarkdownStyleSheet(
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
}