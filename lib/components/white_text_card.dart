import 'package:checkly/model/todo.dart';
import 'package:flutter/material.dart';

class WhiteTextCard extends StatelessWidget {

  final double fontSize;
  final dynamic onPress;
  final String text;

  const WhiteTextCard({Key? key, this.fontSize = 20,
  required this.text,
  required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: key,
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
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
