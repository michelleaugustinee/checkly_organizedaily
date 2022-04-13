import 'package:checkly/components/gradient_background.dart';
import 'package:checkly/components/opaque_center_button.dart';
import 'package:checkly/components/opaque_text_field.dart';
import 'package:checkly/pages/home.dart';
import 'package:flutter/material.dart';

class Guest extends StatelessWidget {
  const Guest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(title: Image.asset("assets/images/ChecklyLogo.png"), centerTitle: true,),
        body: SafeArea(child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Your name is?",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30,),
              OpaqueTextField(hintText: "Name",),
              SizedBox(height: 30,),
              OpaqueCenterButton(text: "Apply", onPress: (){
                Navigator.popAndPushNamed(context, '/home');
              })
            ],
          )
        ),
      ),
    );
  }
}

