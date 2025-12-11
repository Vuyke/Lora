import 'package:flutter/material.dart';

class UIHelpers {
  static AppBar buildGameAppBar(String title) {
    return AppBar(
      toolbarHeight: 35,
      title: Text(
          title,
          style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold
          )
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }
}
