import 'package:checkly/components/dialogs.dart';
import 'package:checkly/components/reorderable_list_view_const.dart';
import 'package:checkly/components/white_text_card.dart';
import 'package:checkly/model/todo.dart';
import 'package:checkly/pages/tasks.dart';
import 'package:checkly/pages/settings.dart';
import 'package:checkly/pages/topics_edit.dart';
import 'package:checkly/utils/shared_preference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:checkly/components/opaque_container_text.dart';
import 'package:checkly/components/opaque_container_child.dart';
import 'package:checkly/components/white_text_button.dart';
import 'package:checkly/components/gradient_background.dart';
import 'package:checkly/components/circular_icon_button.dart';
import 'package:checkly/utils/database_provider.dart';
import 'package:intl/intl.dart';

import '../model/db_models.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DateTime now = DateTime.now();

  User? user;
  String UID = "NoUser";

  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser;
    if(user != null){
      UID = user!.uid;
    }else{
      UID = "NoUser";
    }
    Query topics = FirebaseFirestore.instance
        .collection("Topics")
        .where("UserID", isEqualTo: UID)
        .orderBy("OrderIndex");
    CollectionReference topicsCollection =
        FirebaseFirestore.instance.collection("Topics");

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
             FutureBuilder(
                 future: SharedPreferenceUtil().getName(),
                 builder: (context, snapshot) {
                    return OpaqueContainerText(
                      text: "Hello ${snapshot.data.toString()} :)",
                      fontSize: 40,
                    );
                 }),
            OpaqueContainerText(
              text: DateFormat('EEEE, d MMMM y').format(now),
              fontSize: 20,
            ),
            Expanded(
              child: OpaqueContainerChild(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TO DO",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  user != null?
                  Expanded(
                    child: StreamBuilder(
                      stream: topics.snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text("Loading"),
                          );
                        }
                        return ReorderableListView(
                          children: snapshot.data!.docs.map((topic) {
                            return WhiteTextCard(
                                key: ValueKey("${topic.id}"),
                                text: topic['TopicName'],
                                onPress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Tasks(
                                          topicID: topic.id,
                                          topicName: topic["TopicName"],
                                          UID: UID,
                                        )),
                                  );
                                });
                          }).toList(),
                          onReorder: (oldIndex, newIndex) {
                            ReorderableListViewCheckly().onReorderFireStore(
                                oldIndex, newIndex, snapshot, topicsCollection);
                          },
                          proxyDecorator: (Widget child, int index,
                              Animation<double> animation) {
                            return ReorderableListViewCheckly()
                                .proxyDecorator(child);
                          },
                        );
                      },
                    ),
                  )
                  : Expanded(
                    child: FutureBuilder(
                      future: dbHelper.instance.getTopics(),
                      builder: (context, AsyncSnapshot<List<Topic>> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text("Loading"),
                          );
                        }
                        if (snapshot.data!.length == 0) {
                          return Center(
                            child: Text("No Topic Yet"),
                          );
                        }
                        return ReorderableListView(
                          children: snapshot.data!.map((topic) {
                            return WhiteTextCard(
                                key: ValueKey(topic.id.toString()),
                                text: topic.TopicName,
                                onPress: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Tasks(
                                          topicID: topic.id.toString(),
                                          topicName: topic.TopicName,
                                          UID: UID,
                                        )),
                                  );
                                });
                          }).toList(),
                          onReorder: (oldIndex, newIndex) {
                            ReorderableListViewCheckly().onReorderTopicLocal(
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
                ],
              )),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircularIconButton(
                      icon: Icons.settings_outlined,
                      onPress: () {
                        Navigator.pushNamed(context, '/settings').then((_) => setState(() {}));
                      }),
                  CircularIconButton(
                      icon: Icons.edit,
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => TopicsEdit(
                              UID: UID,
                          ))
                        ).then((_) => setState(() {}));
                      }),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        )),
      ),
    );
  }
}
