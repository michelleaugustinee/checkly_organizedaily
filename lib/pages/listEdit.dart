import 'package:checkly/components/circular_icon_button.dart';
import 'package:checkly/components/dialogs.dart';
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
        resizeToAvoidBottomInset : false,
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
                    TrashFillButton(text: "test", textOnPress: (){},trashOnPress: (){},),
                    TrashFillButton(text: "test", textOnPress: (){},trashOnPress: (){},),
                    TrashFillButton(text: "test", textOnPress: (){},trashOnPress: (){},),
                  ],
                )),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircularIconButton(icon: Icons.add, onPress: () {
                      showTextFieldDialog(
                          context: context,
                          title: "Add Task",
                          label: "Task Name",
                          onPress: (){
                            setState(() {
                              Navigator.pop(context);
                            });
                          }
                      );
                    }),
                    CircularIconButton(icon: Icons.check, onPress: (){
                      showConfirmationdDialog(
                          context: context,
                          title: "Confirm Edit",
                          label: "Are you sure with your edit?",
                          onPress: (){
                            Navigator.pushNamedAndRemoveUntil(context, '/list',  ModalRoute.withName('/home'));
                          }
                      );
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
