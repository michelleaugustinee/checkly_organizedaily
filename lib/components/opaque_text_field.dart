import 'package:flutter/material.dart';

class OpaqueTextField extends StatelessWidget {
  final String hintText;
  final String initialText;
  final textFieldController = TextEditingController();
  final dynamic onChange;
  bool tapOnce = false;
  OpaqueTextField({Key? key, required this.hintText, required this.onChange, this.initialText = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 0),
      decoration: const BoxDecoration(
          color: Color.fromRGBO(255,255,255,0.5),
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      child: TextField(
        textAlign: TextAlign.center,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 25,
              color: Color.fromRGBO(0,0,0,0.3),
              fontWeight: FontWeight.bold
          ),
          border: InputBorder.none,
        ),
        controller: textFieldController,
        onChanged: onChange,
        onTap: (){
          if(!tapOnce){
            textFieldController..text = initialText;
            tapOnce = true;
          }

        },
      ),
    );
  }
}
