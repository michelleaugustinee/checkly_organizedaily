import 'package:flutter/material.dart';

class WhiteTextButton extends StatelessWidget {

  final double fontSize;
  final String text;
  final dynamic onPress;

  const WhiteTextButton({Key? key, this.fontSize = 20, required this.text, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
      child: TextButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
          onPrimary: Color.fromRGBO(32, 227, 178, 1),
          padding: EdgeInsets.all(0),
          primary: Colors.white,

        ),
        onPressed: onPress,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
            width: double.infinity,
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            )
        ),
      ),
    );
  }
}
