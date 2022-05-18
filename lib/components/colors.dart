import 'package:flutter/material.dart';

const Map<String, List<Color>> TaskColor = {
  "white" : [Colors.white, Colors.black, Colors.black],
  "red" : [Colors.red, Colors.white, Colors.black],
  "green" : [Colors.green, Colors.white, Colors.black],
  "blue" : [Colors.blue, Colors.white, Colors.black],
};

class ColorBox extends StatelessWidget {
  final String color;
  final double size;

  const ColorBox({ required this.color, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration:  BoxDecoration(
        color: TaskColor[color]![0],
          border: Border.all(width: 2, color: Colors.black)
      ),
      width: size,
      height: size,
      margin: EdgeInsets.all(size * 0.1),

    );
  }
}
