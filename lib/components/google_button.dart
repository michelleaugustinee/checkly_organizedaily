import 'package:checkly/utils/shared_preference.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/authentication.dart';
import '../pages/home.dart';

class GoogleSignInButton extends StatefulWidget {
  String routeName;

  GoogleSignInButton({Key? key, this.routeName = "/home"}) : super(key: key);

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });

                User? user =
                    await Authentication.signInWithGoogle(context: context);

                setState(() {
                  _isSigningIn = false;
                });

                if (user != null) {
                  await SharedPreferenceUtil().saveName(user.displayName);
                  Navigator.pushReplacementNamed(context, widget.routeName);
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/images/Google.png"),
                      height: 35.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0,right: 30),
                      child: Text(
                        'Google',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

// import 'package:flutter/material.dart';

// class GoogleButton extends StatelessWidget {
//   final dynamic onPress;

//   const GoogleButton({Key? key, required this.onPress}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       style: ElevatedButton.styleFrom(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12), // <-- Radius
//         ),
//         primary: Colors.white,
//         padding: EdgeInsets.all(0),
//         onPrimary: Colors.grey,
//       ),
//       onPressed: onPress,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 10),
//         width: 260,
//         child: Row(
//           children: [
//             Image.asset("assets/images/Google.png", width: 100,),
//             Text(
//               "Google",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: Colors.grey.shade400,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 20,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
