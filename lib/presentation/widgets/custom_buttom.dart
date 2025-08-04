import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Text pomoState;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.pomoState,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
      ),
      child: pomoState,
    );
  }
}
