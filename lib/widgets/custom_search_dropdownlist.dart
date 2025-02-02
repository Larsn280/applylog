import 'package:flutter/material.dart';

class CustomSearchDropdownList extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String?>? onErrorChanged;
  final String? errorMessage;

  const CustomSearchDropdownList({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onErrorChanged,
    required this.errorMessage,
  });

  void _clearErrorMessage() {
    if (errorMessage != null) {
      onErrorChanged?.call(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.black),
          child: Column(
            children: [
              TextField(
                controller: controller,
                onChanged: (_) => _clearErrorMessage(),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontSize: 13.0,
                    color: Colors.white,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorText: errorMessage,
                  errorStyle: TextStyle(color: Colors.red),
                ),
                style: TextStyle(fontSize: 13.0, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
