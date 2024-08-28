import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final IconData? icon;
  final IconButton? sufficicon;
  final TextEditingController controller;
  final FocusNode? focusNode;

  const CustomTextInput(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller,
      this.icon,
      this.sufficicon,
      this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
            ),
            suffixIcon: sufficicon,
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.tertiary),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
            fillColor: Theme.of(context).colorScheme.secondary,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            )),
        obscureText: obscureText,
      ),
    );
  }
}
