import 'package:flutter/material.dart';
import 'package:checkly/components/opaque_container_text.dart';
import 'package:checkly/components/opaque_container_child.dart';
import 'package:checkly/components/white_container_text.dart';
import 'package:checkly/components/gradient_background.dart';
import 'package:checkly/components/circular_icon_button.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(title: Text("CHEKLY LOGO"),centerTitle: true,),
        body: SafeArea(
            child: Column(
              children: [
                OpaqueContainerText(text: "Hello John :)", fontSize: 40,),
                OpaqueContainerText(text: "Tuesday, 19 MArch 2022", fontSize: 20,),
                Expanded(
                  child: OpaqueContainerChild(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("TO DO", style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                          WhiteContainerText(text: "Rapat"),
                          WhiteContainerText(text: "Rapat"),
                          WhiteContainerText(text: "Rapat"),
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
                        onPress: (){}),
                    CircularIconButton(icon: Icons.add,
                        onPress: (){}),
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