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

import '../components/edit_mode_function.dart';
import '../components/white_check_button.dart';

class TasksEdit extends StatefulWidget {
  final String topicID;
  final String topicName;
  const TasksEdit({Key? key, required this.topicID, required this.topicName}) : super(key: key);
  @override
  _TasksEditState createState() => _TasksEditState();
}

class _TasksEditState extends State<TasksEdit> {
  int taskCount = 0;
  @override
  Widget build(BuildContext context) {
    Query tasks = FirebaseFirestore.instance.collection("Tasks").where("TopicID", isEqualTo: widget.topicID).orderBy("OrderIndex");
    CollectionReference taskCollection = FirebaseFirestore.instance.collection("Tasks");


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
              OpaqueContainerText(text: "Tasks Edit"),
              OpaqueContainerText(text: widget.topicName),
              Expanded(
                child: OpaqueContainerChild(
                  child: StreamBuilder(
                    stream: tasks.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text("Loading..."),
                        );
                      }
                      if(snapshot.data!.docs.length == 0){
                        return Center(
                          child: Text("No Tasks Yet"),
                        );
                      }
                      return ListView(
                        children: snapshot.data!.docs.map((task) {
                          taskCount = snapshot.data!.docs.length;
                          // return WhiteCheckButton(text: task['name']);
                          return TrashFillButton(
                            color: "red",
                            text: task['TaskName'],
                            textOnPress: () {
                              final _textFieldController = TextEditingController();

                              showEditTextFieldDialog(
                                  textFieldController:_textFieldController,
                                  context: context,
                                  title: "Edit Task",
                                  label: "Task Name",
                                  initialText: task['TaskName'],
                                  onPress: (){

                                    taskCollection.doc(task.id).update({'TaskName': _textFieldController.text});

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
                                    int index = task["OrderIndex"];
                                    taskCollection.doc(task.id).delete();
                                    EditModeFunction()
                                        .deleteReoderFirestore(
                                        index, taskCount, snapshot, taskCollection);
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
                          showAddTextFieldDialogColor(
                              textFieldController: _textFieldController,
                              context: context,
                              title: "Add Task",
                              label: "Task Name",
                              onPress: () {
                                CollectionReference taskCollection = FirebaseFirestore.instance.collection("Tasks");
                                taskCollection.add({
                                  'TaskName': _textFieldController.text,
                                  'OrderIndex': taskCount,
                                  'TopicID': widget.topicID,
                                  'Color': "red",
                                  'Status': false
                                });
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
