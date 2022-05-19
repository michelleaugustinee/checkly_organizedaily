import 'package:checkly/components/circular_icon_button.dart';
import 'package:checkly/components/dialogs.dart';
import 'package:checkly/components/edit_mode_function.dart';
import 'package:checkly/components/gradient_background.dart';
import 'package:checkly/components/opaque_container_child.dart';
import 'package:checkly/components/opaque_container_text.dart';
import 'package:checkly/components/trash_fill_button.dart';
import 'package:checkly/model/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../components/white_check_button.dart';

class TopicsEdit extends StatefulWidget {
  @override
  _TopicsEditState createState() => _TopicsEditState();
}

class _TopicsEditState extends State<TopicsEdit> {
  int topicsCount = 0;
  @override
  Widget build(BuildContext context) {
    Query topics = FirebaseFirestore.instance.collection("Topics").orderBy("OrderIndex");
    CollectionReference topicsCollection = FirebaseFirestore.instance.collection("Topics");


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
              OpaqueContainerText(text: "Edit Topics"),
              Expanded(
                child: OpaqueContainerChild(
                  child: StreamBuilder(
                    stream: topics.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text("Loading"),
                        );
                      }
                      if (snapshot.data!.docs.length == 0) {
                        return Center(
                          child: Text("No Topic Yet"),
                        );
                      }
                      return ListView(
                        children: snapshot.data!.docs.map((topic) {
                          topicsCount = snapshot.data!.docs.length;
                          // return WhiteCheckButton(text: task['name']);
                          return TrashFillButton(
                            color: "white",
                            text: topic['TopicName'],
                            textOnPress: () {
                              final _textFieldController = TextEditingController();
                              showTopicTextFieldDialog(
                                  textFieldController: _textFieldController,
                                  context: context,
                                  title: "Edit Topic",
                                  initialText: topic['TopicName'],
                                  label: "Topic Name",
                                  onPress: () {
                                    topicsCollection.doc(topic.id).update({'TopicName': _textFieldController.text});
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  });
                            },
                            trashOnPress: () {
                              showConfirmationdDialog(
                                  context: context,
                                  title: "Confirm Delete",
                                  label: "Are you sure want to delete this task?",
                                  onPress: () {
                                    int index = topic["OrderIndex"];
                                    String id = topic.id;
                                    topicsCollection.doc(id).delete();
                                    EditModeFunction()
                                        .deleteTopicFirestore(
                                        id, index, topicsCount, snapshot,topicsCollection);
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  });
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
                          showTopicTextFieldDialog(
                              textFieldController: _textFieldController,
                              context: context,
                              title: "Create New Topic",
                              label: "Topic Name",
                              initialText: "",
                              onPress: () {
                                if (_textFieldController.text != "") {
                                  CollectionReference topics = FirebaseFirestore
                                      .instance
                                      .collection("Topics");
                                  topics.add({
                                    'TopicName': _textFieldController.text,
                                    'OrderIndex': topicsCount,
                                    'UserID': 'test'
                                  });
                                }

                                setState(() {
                                  Navigator.pop(context);
                                });
                              });
                        }),
                    CircularIconButton(
                        icon: Icons.check,
                        onPress: () {
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
