import 'package:checkly/components/google_button.dart';
import 'package:checkly/components/gradient_background.dart';
import 'package:checkly/components/opaque_center_button.dart';
import 'package:checkly/pages/guest_name.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 220,),
              Image.asset("assets/images/ChecklyLogo.png"),
              SizedBox(height: 50,),
              GoogleButton(onPress: (){},),
              SizedBox(height: 250,),
              OpaqueCenterButton(
                text: "Skip",
                onPress: (){
                  Navigator.popAndPushNamed(context, '/guest');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}