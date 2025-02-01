import 'package:flutter/material.dart';

class CustomSearchDropdownList extends StatefulWidget {
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

  @override
  State<CustomSearchDropdownList> createState() =>
      _CustomSearchDropdownListState();
}

class _CustomSearchDropdownListState extends State<CustomSearchDropdownList> {
  void _clearErrorMessage() {
    if (widget.errorMessage != null) {
      widget.onErrorChanged?.call(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.black87),
          child: Column(
            children: [
              TextField(
                controller: widget.controller,
                onChanged: (_) => _clearErrorMessage(),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                    fontSize: 13.0,
                    color: Colors.white,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
                style: TextStyle(fontSize: 13.0, color: Colors.white),
              ),
            ],
          ),
        ),
        if (widget.errorMessage != null)
          Text(
            widget.errorMessage!,
            style: TextStyle(color: Colors.red),
          ),
      ],
    );
  }
}
