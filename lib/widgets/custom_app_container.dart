import 'package:flutter/material.dart';

class CustomAppContainer extends StatelessWidget {
  final Widget child;
  final String titleText;

  const CustomAppContainer({
    super.key,
    required this.child,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        centerTitle: true,
      ),
      body: SizedBox.expand(
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: child,
          ),
        ),
      ),
    );
  }
}
