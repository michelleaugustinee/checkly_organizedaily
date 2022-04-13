import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class TrashFillButton extends StatefulWidget {
  final double fontSize;
  final String text;

  TrashFillButton({Key? key, this.fontSize = 20, required this.text})
      : super(key: key);

  @override
  State<TrashFillButton> createState() => _TrashFillButtonState();
}

class _TrashFillButtonState extends State<TrashFillButton> {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: TextButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
          onPrimary: Color.fromRGBO(32, 227, 178, 1),
          padding: EdgeInsets.all(0),
          // primary: Colors.white,
        ),
        onPressed: () {
          setState(() {});
        },
        child: Row(
          children: [
            Expanded(
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  margin: EdgeInsets.only(right: 15),
                  // width: double.infinity,
                  child: Center(
                    child: Text(
                      widget.text,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.fontSize,
                      ),
                    ),
                  )),
            ),
            Icon(
              CupertinoIcons.trash_fill,
              size: 50,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
