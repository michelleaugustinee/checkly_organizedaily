import 'package:checkly/components/circular_icon_button.dart';
import 'package:checkly/components/gradient_background.dart';
import 'package:checkly/components/opaque_container_child.dart';
import 'package:checkly/components/opaque_container_text.dart';
import 'package:checkly/components/white_check_button.dart';
import 'package:checkly/pages/home.dart';
import 'package:checkly/pages/login.dart';
import 'package:flutter/material.dart';

class SettingGuest extends StatelessWidget {
  const SettingGuest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(title: Image.asset("assets/images/ChecklyLogo.png"), centerTitle: true,),
        body: SafeArea(
          child: Column(
            children: [
              Column(
                children: [
                  OpaqueContainerText(text: "john@gmail.com"),
                  OpaqueContainerText(text: "Edit Profile", fontSize: 40,),
                  SizedBox(height: 10,),
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
                  OpaqueContainerText(text: "John", fontSize: 35,),
                  SizedBox(height: 10,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: MediaQuery.of(context).size.width*0.3,
                    height: MediaQuery.of(context).size.width*0.1,
                    child: Center(
                      child:
                      TextButton(
                      style: ElevatedButton.styleFrom( 
                        shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12), // <-- Radius
                              ),
                              primary: Color.fromRGBO(255,255,255,0.5),
                              padding: EdgeInsets.all(0),
                              onPrimary: Colors.white,
                        ),
                        onPressed: (){
                          Navigator.push(context, 
                            MaterialPageRoute(
                              builder: (context){
                                return Home();
                              }),);
                        },
                            child: Container(
                                width: double.infinity,
                                child: Text(
                                  "Apply",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                )
                            ),
                          ),
                      )
                    ),
                ],
              ),
              SizedBox(height: 150,),
              Padding(
                padding: const EdgeInsets.only(left: 80),
                child: Row(
                  children: [
                    Text("Log In with",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        ),),
                  ],
                ),
              ),
                    SizedBox(height: 10,),
              Column(
                children: [
                  TextButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // <-- Radius
                  ),
                  primary: Colors.white,
                  padding: EdgeInsets.all(0),
                  onPrimary: Colors.grey,
                ),
                onPressed: () {
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: 260,
                child: Row(
                  children: [
                    Image.asset("assets/images/Google.png", width: 100,),
                    Text(
                    "Google",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              ),
                ],
              ),
              SizedBox(height: 20,),
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
            ],
          ),
        ),
      ),
    );
  }
}