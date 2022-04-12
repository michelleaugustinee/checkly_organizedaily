import 'package:flutter/material.dart';

class WhiteContainerText extends StatelessWidget {

  final double fontSize;
  final String text;

  const WhiteContainerText({Key? key, this.fontSize = 20, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
      decoration: const BoxDecoration(
          color: Color.fromRGBO(255,255,255,0.5),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      width: MediaQuery.of(context).size.width,
      child: Text(text, style: TextStyle( fontSize: fontSize, fontWeight: FontWeight.bold),),
    );
  }
}
