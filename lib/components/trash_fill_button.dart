import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:checkly/components/colors.dart';

class TrashFillButton extends StatefulWidget {
  final double fontSize;
  final String text;
  final textOnPress;
  final trashOnPress;
  final String color;

  TrashFillButton({Key? key,
    this.fontSize = 20,
    required this.text,
    required this.textOnPress,
    required this.trashOnPress,
    this.color = "white"
  })
      : super(key: key);

  @override
  State<TrashFillButton> createState() => _TrashFillButtonState();
}

class _TrashFillButtonState extends State<TrashFillButton> {
  List<Color> colorSet = [];
  @override
  void initState() {
    colorSet = TaskColor[widget.color]!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
                onPrimary: Color.fromRGBO(32, 227, 178, 1),
                primary: colorSet[0],
                padding: EdgeInsets.all(0),
                // primary: Colors.white,
              ),
              onPressed: widget.textOnPress,
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  margin: EdgeInsets.only(right: 15),
                  // width: double.infinity,
                  child: Center(
                    child: Text(
                      widget.text,
                      style: TextStyle(
                        color: colorSet[1],
                        fontWeight: FontWeight.bold,
                        fontSize: widget.fontSize,
                      ),
                    ),
                  )),
            ),
          ),
          SizedBox(width: 5),
          InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: widget.trashOnPress,
            splashColor: Colors.white,
            child: Icon(
              CupertinoIcons.trash_fill,
              size: 45,
              color:  colorSet[0],
            ),
          ),
        ],
      ),
    );
  }
}
