import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color textColor;

  // Constructor
  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.buttonColor = Colors.blue, // Default button color
    this.textColor = Colors.white,  // Default text color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(buttonColor),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
        )),
        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
          vertical: 16.0, // Vertical padding
          horizontal: 20.0, // Horizontal padding
        )),
        elevation: MaterialStateProperty.all(5), // Shadow effect
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor, // Text color
          fontSize: 16.0, // Font size
          fontWeight: FontWeight.bold, // Bold text for emphasis
        ),
      ),
    );
  }
}
