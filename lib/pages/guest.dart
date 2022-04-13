import 'package:checkly/components/gradient_background.dart';
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
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(height: 200),
                Text("Your name is?",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20,),
                TextFieldContainer(
                  child: TextField(
                    textAlign: TextAlign.center,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(
                            fontSize: 25,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold
                          ),
                          border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                TextButton(
                  style: ElevatedButton.styleFrom( 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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
                    width: 100,
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
              ],
            ),
          )
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget{
  final Widget child;
    const TextFieldContainer({
      Key? key, 
      required this.child,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        width: size.width * 0.9,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255,255,255,0.5),
          borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: child,
      );
    }
}