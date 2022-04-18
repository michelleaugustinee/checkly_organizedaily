import 'package:checkly/components/circular_icon_button.dart';
import 'package:checkly/components/dialogs.dart';
import 'package:checkly/components/gradient_background.dart';
import 'package:checkly/components/opaque_container_child.dart';
import 'package:checkly/components/opaque_container_text.dart';
import 'package:checkly/components/trash_fill_button.dart';
import 'package:checkly/model/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../components/white_check_button.dart';

class ListEdit extends StatefulWidget {
  @override
  _ListEditState createState() => _ListEditState();
}

class _ListEditState extends State<ListEdit> {
  @override
  Widget build(BuildContext context) {
    CollectionReference test = FirebaseFirestore.instance.collection("test");

    return GradientBackground(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                  child: StreamBuilder(
                    stream: test.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text("Loading"),
                        );
                      }
                      return ListView(
                        children: snapshot.data!.docs.map((task) {
                          // return WhiteCheckButton(text: task['name']);
                          return TrashFillButton(
                            text: task['name'],
                            textOnPress: () {
                              final _textFieldController = TextEditingController();

                              showEditTextFieldDialog(
                                  textFieldController:_textFieldController,
                                  context: context,
                                  title: "Edit Task",
                                  label: "Task Name",
                                  initialText: task['name'],
                                  onPress: (){
                                    test.doc(task.id).update({'name': _textFieldController.text});
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  });
                            },
                            trashOnPress: () {
                              test.doc(task.id).delete();
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                  // child: Expanded(
                  //   child: ListView.builder(
                  //       itemCount: todos.length,
                  //       itemBuilder: (context, index){
                  //         return TrashFillButton(
                  //           text: todos[index].title,
                  //           textOnPress: (){
                  //             showEditTextFieldDialog(context: context,
                  //                 title: "Edit Task",
                  //                 label: "Task Name",
                  //                 initialText: todos[index].title,
                  //                 onPress: (){
                  //                   setState(() {
                  //                     Navigator.pop(context);
                  //                   });
                  //                 }
                  //             );
                  //           },
                  //           trashOnPress: (){},);
                  //       }),
                  // )
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircularIconButton(
                        icon: Icons.add,
                        onPress: () {
                          final _textFieldController = TextEditingController();
                          showTextFieldDialog(
                              textFieldController: _textFieldController,
                              context: context,
                              title: "Add Task",
                              label: "Task Name",
                              onPress: () {
                                CollectionReference test = FirebaseFirestore.instance.collection("test");
                                test.add({'name': _textFieldController.text});
                                setState(() {
                                  Navigator.pop(context);
                                });
                              });
                        }),
                    CircularIconButton(
                        icon: Icons.check,
                        onPress: () {
                          showConfirmationdDialog(
                              context: context,
                              title: "Confirm Edit",
                              label: "Are you sure with your edit?",
                              onPress: () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    '/list', ModalRoute.withName('/home'));
                              });
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
