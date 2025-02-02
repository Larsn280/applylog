import 'package:flutter/material.dart';

class CustomSearchDropdownList extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  const CustomSearchDropdownList({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
  });

  @override
  CustomSearchDropdownListState createState() =>
      CustomSearchDropdownListState();
}

class CustomSearchDropdownListState extends State<CustomSearchDropdownList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.black),
          child: Column(
            children: [
              TextFormField(
                controller: widget.controller,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                    fontSize: 13.0,
                    color: Colors.white,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                style: TextStyle(fontSize: 13.0, color: Colors.white),
                validator: widget.validator,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
