import 'package:checkly/components/circular_icon_button.dart';
import 'package:checkly/components/google_button.dart';
import 'package:checkly/components/gradient_background.dart';
import 'package:checkly/components/opaque_center_button.dart';
import 'package:checkly/components/opaque_container_child.dart';
import 'package:checkly/components/opaque_container_text.dart';
import 'package:checkly/components/opaque_text_field.dart';
import 'package:checkly/components/white_check_button.dart';
import 'package:checkly/pages/home.dart';
import 'package:checkly/pages/login.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool guest = false;

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        resizeToAvoidBottomInset : false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(title: Image.asset("assets/images/ChecklyLogo.png"), centerTitle: true,),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(

                children: [
                  guest? SizedBox.shrink() : OpaqueContainerText(text: "john@gmail.com"),
                  OpaqueContainerText(text: "Edit Profile", fontSize: 40,),
                  SizedBox(height: 5,),
                  Padding(
                    padding: EdgeInsets.only(left: 22),
                    child: Row(
                      children: [
                        Text("Edit Name",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.white,
                          ),),
                      ],
                    ),
                    ),
                  OpaqueTextField(
                    hintText: "Name",
                    onChange: (value){},
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OpaqueCenterButton(text: "Apply", onPress: (){})
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  guest? Text("Log In with",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white),)
                      : SizedBox.shrink(),
                  SizedBox(height: 10,),
                  guest? GoogleButton(onPress: (){
                    setState(() {guest = false;});
                  },)
                  : OpaqueCenterButton(
                      text: "Log Out",
                      onPress:(){
                        setState(() {guest = true;});
                      }),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircularIconButton(icon: Icons.settings_outlined,
                            onPress: (){
                              Navigator.pop(context);
                            }),
                      ],),
                  ),
                  SizedBox(height: 30,)
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}