import 'package:checkly/components/circular_icon_button.dart';
import 'package:checkly/components/dialogs.dart';
import 'package:checkly/components/google_button.dart';
import 'package:checkly/components/gradient_background.dart';
import 'package:checkly/components/opaque_center_button.dart';
import 'package:checkly/components/opaque_container_child.dart';
import 'package:checkly/components/opaque_container_text.dart';
import 'package:checkly/components/opaque_text_field.dart';
import 'package:checkly/components/white_check_button.dart';
import 'package:checkly/pages/home.dart';
import 'package:checkly/pages/login.dart';
import 'package:checkly/utils/shared_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/authentication.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _isSigningOut = false;
  // Route _routeToSignInScreen() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => Login(),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       var begin = Offset(-1.0, 0.0);
  //       var end = Offset.zero;
  //       var curve = Curves.ease;
  //
  //       var tween =
  //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  //
  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }

  String username = "";
  String email = "";
  bool isLoggedIn = false;
  User? user;
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      isLoggedIn = true;
      email = user!.email!;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  !isLoggedIn
                      ? SizedBox.shrink()
                      : OpaqueContainerText(text: "${email}"),
                  OpaqueContainerText(
                    text: "Edit Profile",
                    fontSize: 40,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 22),
                    child: Row(
                      children: [
                        Text(
                          "Edit Name",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder(
                      future: SharedPreferenceUtil().getName(),
                      builder: (context, snapshot) {
                        return OpaqueTextField(
                          hintText: snapshot.data.toString(),
                          initialText: snapshot.data.toString(),
                          onChange: (value) {
                            username = value;
                          },
                        );
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OpaqueCenterButton(
                            text: "Apply",
                            onPress: () {
                              showConfirmationdDialog(
                                  context: context,
                                  title: "Confirm Edit",
                                  label: "Are you sure with your edit?",
                                  onPress: () async{
                                    await SharedPreferenceUtil().saveName(username);
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, '/home', ((route) => false));
                                  });
                            })
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  !isLoggedIn ?
                  Text("Log In with",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )
                      : SizedBox.shrink(),
                  SizedBox(
                    height: 10,
                  ),
                  !isLoggedIn
                      ? GoogleSignInButton(routeName: "/settings",)
                      : OpaqueCenterButton(
                    text: "Log Out",
                    onPress: () async {
                      setState(() {
                        _isSigningOut = true;
                      });
                      await Authentication.signOut(context: context);
                      setState(() {
                        _isSigningOut = false;
                      });
                      // Navigator.of(context)
                      //     .pushReplacement(_routeToSignInScreen());
                      setState(() {isLoggedIn = false;});
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircularIconButton(
                            icon: Icons.settings_outlined,
                            onPress: () {
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
