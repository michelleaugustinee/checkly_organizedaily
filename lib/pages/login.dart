import 'package:checkly/components/gradient_background.dart';
import 'package:checkly/pages/guest.dart';
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
              SizedBox(height: 250,),
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
                  MaterialPageRoute(builder: (context) {
                    return const Guest();
                  }),);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                    width: 150,
                    child: Text(
                      "Skip",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}