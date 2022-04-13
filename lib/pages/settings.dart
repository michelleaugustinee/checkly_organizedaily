import 'package:checkly/components/circular_icon_button.dart';
import 'package:checkly/components/gradient_background.dart';
import 'package:checkly/components/opaque_container_child.dart';
import 'package:checkly/components/opaque_container_text.dart';
import 'package:checkly/components/white_check_button.dart';
import 'package:checkly/pages/home.dart';
import 'package:checkly/pages/login.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

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
                  SizedBox(height: 5,),
                  Text("Edit Name", style: TextStyle(fontWeight: FontWeight.bold),),
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
              SizedBox(height: 170,),
              Column(
                children: [
                  Container(
                        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10))),
                        width: MediaQuery.of(context).size.width*0.5,
                        height: MediaQuery.of(context).size.width*0.15,
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
                                    return Login();
                                  }),);
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                                width: double.infinity,
                                child: Text(
                                  "Log Out",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                )
                            ),
                          ),
                        ),
                        
                      ),
                ],
              ),
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