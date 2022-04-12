import 'package:flutter/material.dart';

class OpaqueContainerText extends StatelessWidget {

  final double fontSize;
  final String text;

  const OpaqueContainerText({Key? key, this.fontSize = 20, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0),
      decoration: const BoxDecoration(
          color: Color.fromRGBO(255,255,255,0.5),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      width: MediaQuery.of(context).size.width,
      child: Center(child:Text(text, style: TextStyle( fontSize: fontSize, fontWeight: FontWeight.bold),)),
    );
  }
}
