import 'package:checkly/components/circular_icon_button.dart';
import 'package:checkly/components/gradient_background.dart';
import 'package:checkly/components/opaque_container_child.dart';
import 'package:checkly/components/opaque_container_text.dart';
import 'package:checkly/components/white_check_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class List extends StatefulWidget {
  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(title: Image.asset("assets/images/ChecklyLogo.png"), centerTitle: true,),
        body: SafeArea(
          child: Column(
            children: [
              OpaqueContainerText(text: "Shopping List"),
              Expanded(
                child: OpaqueContainerChild(
                    child: Column(
                      children: [
                        WhiteCheckButton(text: "test"),
                        WhiteCheckButton(text: "test"),
                        WhiteCheckButton(text: "test"),
                      ],)),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    CircularIconButton(icon: Icons.edit,
                        onPress: (){}),
                  ],),
              ),
              SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }
}
