import 'package:checkly/components/google_button.dart';
import 'package:checkly/components/gradient_background.dart';
import 'package:checkly/components/opaque_center_button.dart';
import 'package:checkly/pages/guest_name.dart';
import 'package:flutter/material.dart';
import '../auth/authentication.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 220,
              ),
              Image.asset("assets/images/ChecklyLogo.png"),
              SizedBox(
                height: 50,
              ),
              FutureBuilder(
                future: Authentication.initializeFirebase(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error initializing Firebase');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return GoogleSignInButton();
                  }
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.orange,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 250,
              ),
              OpaqueCenterButton(
                text: "Skip",
                onPress: () {
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
