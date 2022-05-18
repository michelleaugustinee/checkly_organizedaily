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

class Tasks extends StatefulWidget {
  final String topicID;
  final String topicName;

  const Tasks({Key? key, required this.topicID, required this.topicName}) : super(key: key);

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
                      return ReorderableListView(
                        children: snapshot.data!.docs.map((task) {
                          bool status = task['Status'];
                          return WhiteCheckButton(
                              key: ValueKey("${task.id}"),
                              text: task['TaskName'],
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
                                topicName: widget.topicName,)),
                        );
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
