import 'package:checkly/pages/guest_name.dart';
import 'package:flutter/material.dart';

class OpaqueCenterButton extends StatelessWidget {
  final double fontSize;
  final String text;
  final dynamic onPress;

  const OpaqueCenterButton({Key? key, this.fontSize = 20, required this.text, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // <-- Radius
        ),
        primary: Color.fromRGBO(255,255,255,0.5),
        padding: EdgeInsets.all(0),
        onPrimary: Colors.white,
      ),
      onPressed: onPress,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
          width: 150,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          )
      ),
    );
  }
}
