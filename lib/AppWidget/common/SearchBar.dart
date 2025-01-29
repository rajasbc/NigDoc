import 'package:flutter/material.dart';
import '../../../AppWidget/common/Colors.dart' as custom_color;


class SearchBarWithIcons extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onTextChanged;
  final VoidCallback onClearPressed;
  final VoidCallback onSearchPressed;

  const SearchBarWithIcons({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.onTextChanged,
    required this.onClearPressed,
    required this.onSearchPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: custom_color.appcolor),
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
      child: Row(
        children: [
         
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: (text) {
                onTextChanged(text);
              },
              decoration: InputDecoration(
                filled: true,
                border: InputBorder.none,
                fillColor: Colors.white,
                hintText: hintText,
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),

          IconButton(
            icon: Icon(
              controller.text.isNotEmpty ? Icons.close : Icons.search,
              color: controller.text.isNotEmpty ? Colors.red : custom_color.appcolor,
            ),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                onClearPressed();
              } else {
                onSearchPressed();
              }
            },
          ),
        ],
      ),
    );
  }
}
