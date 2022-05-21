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
import 'package:checkly/utils/database_provider.dart';
import '../components/edit_mode_function.dart';
import '../components/white_check_button.dart';
import '../model/db_models.dart';

class TasksEdit extends StatefulWidget {
  final String topicID;
  final String topicName;
  final String UID;

  const TasksEdit({Key? key,
    required this.topicID,
    required this.topicName,
    required this.UID}) : super(key: key);
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
                  child:
                  widget.UID != "NoUser"?
                  StreamBuilder(
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
                            color: task["Color"],
                            text: task['TaskName'],
                            textOnPress: () {
                              final _textFieldController = TextEditingController();
                               showTaskTextFieldDialog(
                                  textFieldController:_textFieldController,
                                  context: context,
                                  title: "Edit Task",
                                  label: "Task Name",
                                  initialText: task['TaskName'],
                                  initialColor: task['Color'],
                                  onPress: (String color){
                                    taskCollection.doc(task.id).update({'TaskName': _textFieldController.text, 'Color': color});
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
                                        .deleteTaskFirestore(
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
                  )
                  : FutureBuilder(
                    future: dbHelper.instance.getTasks(widget.topicID),
                    builder: (context, AsyncSnapshot<List<Task>> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Text("Loading..."),
                        );
                      }
                      if(snapshot.data!.length == 0){
                        return Center(
                          child: Text("No Tasks Yet"),
                        );
                      }
                      return ListView(
                        children: snapshot.data!.map((task) {
                          taskCount = snapshot.data!.length;
                          // return WhiteCheckButton(text: task['name']);
                          return TrashFillButton(
                            color: task.Color,
                            text: task.TasksName,
                            textOnPress: () {
                              final _textFieldController = TextEditingController();
                              showTaskTextFieldDialog(
                                  textFieldController:_textFieldController,
                                  context: context,
                                  title: "Edit Task",
                                  label: "Task Name",
                                  initialText: task.TasksName,
                                  initialColor: task.Color,
                                  onPress: (String color){
                                    // taskCollection.doc(task.id).update({'TaskName': _textFieldController.text, 'Color': color});
                                    dbHelper.instance.updateTask(task.id as int, _textFieldController.text, color);
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
                                    int index = task.OrderIndex;
                                    EditModeFunction()
                                        .deleteTaskLocal(
                                        task.id as int, index, taskCount, snapshot);
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
                          showTaskTextFieldDialog(
                              textFieldController: _textFieldController,
                              context: context,
                              title: "Add Task",
                              initialText: "",
                              initialColor: "white",
                              label: "Task Name",
                              onPress: (String color) {
                                if(_textFieldController.text != ""){
                                  if(widget.UID == "NoUser"){
                                    dbHelper.instance.addTask(
                                        Task(
                                            OrderIndex: taskCount,
                                            TasksName: _textFieldController.text,
                                            Status: 0,
                                            Color: color,
                                            TopicID: widget.topicID
                                        ));
                                  }else{
                                    CollectionReference taskCollection = FirebaseFirestore.instance.collection("Tasks");
                                    taskCollection.add({
                                      'TaskName': _textFieldController.text,
                                      'OrderIndex': taskCount,
                                      'TopicID': widget.topicID,
                                      'Color': color,
                                      'Status': false
                                    });
                                  }

                                }
                                setState(() {
                                  Navigator.pop(context);
                                });
                              });
                        }),
                    CircularIconButton(
                        icon: Icons.check,
                        onPress: () {
                          setState(() {
                            Navigator.pop(context);
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
