import 'package:flutter/material.dart';
import 'package:splashh/utils/color.dart';
class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const ButtonWidget({Key? key, required this.buttonText, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor, // Updated hex code
        minimumSize: Size(200, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

}