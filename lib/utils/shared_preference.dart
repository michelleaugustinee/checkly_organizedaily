import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtil{


  saveName(username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", username.toString());
  }
  getName() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = await prefs.getString("username");
    return name;
  }


  // retrieve() async{
  //   _getInstance();
  //   name = prefs.getString("username");
  //   setState(() {
  //
  //   });
  // }

  // delete() async
  // {
  //   _getInstance();
  //   prefs.remove("username");
  //   name = "";
  //   setState(() {
  //
  //   });
  // }

}