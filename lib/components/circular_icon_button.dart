import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {

  final dynamic onPress;
  final dynamic icon;

  CircularIconButton({required this.icon, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
        child: Material(
          color: Color.fromRGBO(255,255,255,0.5), // Button color
          child: InkWell(
            splashColor: Color.fromRGBO(255,255,255,0.8), // Splash color
            child: SizedBox(width: 75, height: 75, child: Icon(icon, size: 50, color: Colors.white,)),
            onTap: onPress,
          ),
        ),
      );
  }
}
