import 'package:checkly/components/dialogs.dart';
import 'package:checkly/model/todo.dart';
import 'package:checkly/pages/list.dart';
import 'package:checkly/pages/settings.dart';
import 'package:checkly/utils/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:checkly/components/opaque_container_text.dart';
import 'package:checkly/components/opaque_container_child.dart';
import 'package:checkly/components/white_text_button.dart';
import 'package:checkly/components/gradient_background.dart';
import 'package:checkly/components/circular_icon_button.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        resizeToAvoidBottomInset : false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(title: Image.asset("assets/images/ChecklyLogo.png"), centerTitle: true,),
        body: SafeArea(
            child: Column(
              children: [
                FutureBuilder(
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
                            child: ListView.builder(
                                itemCount: todos.length,
                                itemBuilder: (context, index){
                                  return WhiteTextButton(
                                      text: todos[index].title,
                                      onPress: (){
                                        Navigator.pushNamed(context, '/list');
                                      });
                                }),
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
                    CircularIconButton(icon: Icons.add,
                        onPress: (){
                          showTextFieldDialog(
                            context:context,
                            title: "Create New List",
                            label: "List Name",
                            onPress: (){
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
