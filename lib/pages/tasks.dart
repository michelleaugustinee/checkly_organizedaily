import 'package:checkly/components/circular_icon_button.dart';
import 'package:checkly/components/gradient_background.dart';
import 'package:checkly/components/opaque_container_child.dart';
import 'package:checkly/components/opaque_container_text.dart';
import 'package:checkly/components/reorderable_list_view_const.dart';
import 'package:checkly/components/white_check_button.dart';
import 'package:checkly/model/todo.dart';
import 'package:checkly/pages/tasks_edit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:checkly/utils/database_provider.dart';

import '../model/db_models.dart';

class Tasks extends StatefulWidget {
  final String topicID;
  final String topicName;
  final String UID;

  const Tasks({Key? key, required this.topicID, required this.topicName, required this.UID}) : super(key: key);

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Query tasks =
        FirebaseFirestore.instance.collection("Tasks").where("TopicID", isEqualTo: widget.topicID).orderBy("OrderIndex");
    CollectionReference taskCollection =
        FirebaseFirestore.instance.collection("Tasks");

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
              OpaqueContainerText(text: widget.topicName),
              Expanded(
                child: OpaqueContainerChild(
                  // child: ListView.builder(
                  //     itemCount: todos.length,
                  //     itemBuilder: (context, index){
                  //       return WhiteCheckButton(text: todos[index].title);
                  //     }),
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
                      return ReorderableListView(
                        children: snapshot.data!.docs.map((task) {
                          bool status = task['Status'];
                          return WhiteCheckButton(
                              key: ValueKey("${task.id}"),
                              text: task['TaskName'],
                            color: task["Color"].toString(),
                            status: status,
                            onPress: (){
                                if(status){
                                  taskCollection.doc(task.id).update({'Status' : false});
                                }else{
                                  taskCollection.doc(task.id).update({'Status' : true});
                                }
                            },
                          );

                        }).toList(),
                        onReorder: (oldIndex, newIndex) {
                          ReorderableListViewCheckly().onReorderFireStore(
                              oldIndex, newIndex, snapshot, taskCollection);
                        },
                        proxyDecorator: (Widget child, int index,
                            Animation<double> animation) {
                          return ReorderableListViewCheckly()
                              .proxyDecorator(child);
                        },
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
                      return ReorderableListView(
                        children: snapshot.data!.map((task) {
                          int status = task.Status;
                          return WhiteCheckButton(
                            key: ValueKey("${task.id}"),
                            text: task.TasksName,
                            color: task.Color,
                            status: status == 0? false : true,
                            onPress: ()async{
                              if(status == 0){
                                await dbHelper.instance.updateTaskStatus(task.id as int, 1);

                              }else{
                                await dbHelper.instance.updateTaskStatus(task.id as int, 0);
                              }
                              setState(() {});
                            },
                          );

                        }).toList(),
                        onReorder: (oldIndex, newIndex) {
                          ReorderableListViewCheckly().onReorderTaskLocal(
                              oldIndex, newIndex, snapshot);
                          setState(() {});
                        },
                        proxyDecorator: (Widget child, int index,
                            Animation<double> animation) {
                          return ReorderableListViewCheckly()
                              .proxyDecorator(child);
                        },
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
                    SizedBox(),
                    CircularIconButton(
                      icon: Icons.edit,
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TasksEdit(
                                topicID: widget.topicID,
                                topicName: widget.topicName,
                                UID: widget.UID,
                              )),
                        ).then((_) => setState(() {}));
                      },
                    ),
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
