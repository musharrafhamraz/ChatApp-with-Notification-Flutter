import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btnText;
  final void Function() onTap;
  const CustomButton({super.key, required this.btnText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Center(
          child: Text(btnText),
        ),
      ),
    );
  }
}
