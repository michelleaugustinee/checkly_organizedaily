import 'package:checkly/components/circular_icon_button.dart';
import 'package:checkly/components/gradient_background.dart';
import 'package:checkly/components/opaque_container_child.dart';
import 'package:checkly/components/opaque_container_text.dart';
import 'package:checkly/components/trash_fill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ListEdit extends StatefulWidget {
  @override
  _ListEditState createState() => _ListEditState();
}

class _ListEditState extends State<ListEdit> {
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Image.asset("assets/images/ChecklyLogo.png"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              OpaqueContainerText(text: "Shopping List"),
              Expanded(
                child: OpaqueContainerChild(
                    child: Column(
                  children: [
                    TrashFillButton(text: "test"),
                    TrashFillButton(text: "test"),
                    TrashFillButton(text: "test"),
                  ],
                )),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircularIconButton(icon: Icons.add, onPress: () {}),
                    CircularIconButton(icon: Icons.edit, onPress: () {
                      Navigator.pop(context);
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
