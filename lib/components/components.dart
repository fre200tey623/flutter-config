import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const TextLink({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.blue,
        ),
      ),
    );
  }
}
