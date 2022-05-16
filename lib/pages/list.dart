import 'package:checkly/components/circular_icon_button.dart';
import 'package:checkly/components/gradient_background.dart';
import 'package:checkly/components/opaque_container_child.dart';
import 'package:checkly/components/opaque_container_text.dart';
import 'package:checkly/components/reorderable_list_view_const.dart';
import 'package:checkly/components/white_check_button.dart';
import 'package:checkly/model/todo.dart';
import 'package:checkly/pages/listEdit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class List extends StatefulWidget {
  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<List> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Query tasks =
        FirebaseFirestore.instance.collection("Tasks").orderBy("OrderIndex");
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
              OpaqueContainerText(text: "Shopping List"),
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
                          child: Text("Loading"),
                        );
                      }
                      return ReorderableListView(
                        children: snapshot.data!.docs.map((task) {
                          return WhiteCheckButton(
                              key: ValueKey("${task.id}"),
                              text: task['TaskName']);
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
                        Navigator.pushNamed(context, '/listEdit');
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
