import 'package:checkly/components/dialogs.dart';
import 'package:checkly/components/reorderable_list_view_const.dart';
import 'package:checkly/components/white_text_card.dart';
import 'package:checkly/model/todo.dart';
import 'package:checkly/pages/list.dart';
import 'package:checkly/pages/settings.dart';
import 'package:checkly/utils/shared_preference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:checkly/components/opaque_container_text.dart';
import 'package:checkly/components/opaque_container_child.dart';
import 'package:checkly/components/white_text_button.dart';
import 'package:checkly/components/gradient_background.dart';
import 'package:checkly/components/circular_icon_button.dart';

import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key,}) :  super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final DateTime now = DateTime.now();
  bool hasUser = false;
  User? user;
  int listCount = 0;
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      hasUser = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Query lists = FirebaseFirestore.instance.collection("Lists").orderBy("OrderIndex");
    CollectionReference listsCollection = FirebaseFirestore.instance.collection("Lists");
    return GradientBackground(
      child: Scaffold(
        resizeToAvoidBottomInset : false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(title: Image.asset("assets/images/ChecklyLogo.png"), centerTitle: true,),
        body: SafeArea(
            child: Column(
              children: [
                hasUser? FutureBuilder(
                    future: SharedPreferenceUtil().getName(),
                    builder: (context, snapshot) {
                      return OpaqueContainerText(text: "Hello ${user!.displayName} :)", fontSize: 40,);
                    })
                : FutureBuilder(
                    future: SharedPreferenceUtil().getName(),
                    builder: (context, snapshot) {
                      return OpaqueContainerText(text: "Hello ${snapshot.data.toString()} :)", fontSize: 40,);
                    }),

                OpaqueContainerText(text: DateFormat('EEEE, d MMMM y').format(now), fontSize: 20,),
                Expanded(
                  child: OpaqueContainerChild(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("TO DO", style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                          Expanded(
                            child: StreamBuilder(
                              stream: lists.snapshots(),
                              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: Text("Loading"),
                                  );
                                }
                                return ReorderableListView(
                                    children: snapshot.data!.docs.map((list){
                                      listCount = snapshot.data!.docs.length;
                                      return WhiteTextCard(
                                          key: ValueKey("${list['OrderIndex']}"),
                                          text: list['ListName'],
                                          onPress: (){
                                            Navigator.pushNamed(context, '/list');
                                          });

                                    }).toList(),
                                    onReorder: (oldIndex,  newIndex){
                                      ReorderableListViewCheckly().onReorderFireStore(oldIndex, newIndex, snapshot, listsCollection);
                                    },
                                    proxyDecorator: (Widget child, int index, Animation<double> animation) {
                                      return ReorderableListViewCheckly().proxyDecorator(child);
                                    },
                                );
                              },
                            ),
                          ),
                        ],
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    CircularIconButton(icon: Icons.settings_outlined,
                        onPress: (){
                          Navigator.pushNamed(context, '/settings');
                        }),
                    CircularIconButton(
                        icon: Icons.add,
                        onPress: (){
                          final _textFieldController = TextEditingController();
                          showTextFieldDialog(
                              textFieldController: _textFieldController,
                            context:context,
                            title: "Create New List",
                            label: "List Name",
                            onPress: (){
                                if(_textFieldController.text != ""){
                                  CollectionReference lists = FirebaseFirestore.instance.collection("Lists");
                                  lists.add({
                                    'ListName': _textFieldController.text,
                                    'OrderIndex': listCount ,
                                    'UserID' : 'test'
                                  });
                                }

                              setState(() {
                                Navigator.pop(context);
                              });
                            }
                          );
                        }),
                  ],),
                ),
                SizedBox(height: 30,)
              ],
            )
        ),

      ),
    );
  }
}
