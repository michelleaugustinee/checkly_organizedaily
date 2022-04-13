import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  final dynamic onPress;

  const GoogleButton({Key? key, required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // <-- Radius
        ),
        primary: Colors.white,
        padding: EdgeInsets.all(0),
        onPrimary: Colors.grey,
      ),
      onPressed: onPress,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: 260,
        child: Row(
          children: [
            Image.asset("assets/images/Google.png", width: 100,),
            Text(
              "Google",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
