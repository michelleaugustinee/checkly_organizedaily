import 'package:flutter/material.dart';
import 'package:checkly/components/colors.dart';

class WhiteCheckButton extends StatefulWidget {

  final double fontSize;
  final String text;
  final onPress;
  final bool status;
  final String color;
  const WhiteCheckButton({Key? key,
    this.fontSize = 20,
    required this.text,
    required this.onPress,
    required this.status,
    required this.color}) : super(key: key);

  @override
  State<WhiteCheckButton> createState() => _WhiteCheckButtonState();
}

class _WhiteCheckButtonState extends State<WhiteCheckButton> {

  @override

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
          // primary: Colors.white,

        ),
        onPressed: widget.onPress,
        child: Row(
          children: [
            Expanded(
              child: Container(
                  decoration:  BoxDecoration(
                      color:  widget.status? Colors.white.withOpacity(0.6): Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    border: Border.all(style: BorderStyle.solid, width: 5, color: TaskColor[widget.color]!)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                  margin: EdgeInsets.only(right: 15),
                  // width: double.infinity,
                  child: Center(
                    child: Text(
                      widget.text,
                      style: TextStyle(
                        color: widget.status? Colors.grey : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.fontSize,
                        decoration: widget.status? TextDecoration.lineThrough :  TextDecoration.none
                      ),
                    ),
                  )),
            ),
            widget.status?
            Icon(Icons.check_box_outlined,size: 50,color: TaskColor[widget.color]!,) :
            Icon(Icons.check_box_outline_blank,size: 50,color: TaskColor[widget.color]!,)
          ],
        ),
      ),
    );
  }
}
