import 'package:flutter/material.dart';

class AppConstants {
  static ThemeData themeData = ThemeData();

  static Widget buildMainContainer(
      {required BuildContext context,
      required Widget child,
      required String titleText}) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black87,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: child,
        ),
      ),
    );
  }
}
