import 'package:flutter/material.dart';

const Map<String, Color> TaskColor = {
  "white" : Colors.white,
  "red" : Colors.red,
  "green" : Colors.green,
  "blue" : Colors.blue,
};

class ColorBox extends StatelessWidget {
  final String color;
  final double size;
  final bool selected;
  const ColorBox({ required this.color, this.size = 20, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
          border:  Border.all(width: 2, color: selected? Colors.black : Colors.grey.withOpacity(0.5))
      ),
      margin: EdgeInsets.all(size * 0.1),
      padding: EdgeInsets.all(2),
      child: Container(
        width: size,
        height: size,
        color: TaskColor[color]
      ),
    );
  }
}
