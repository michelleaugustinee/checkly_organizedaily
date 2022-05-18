import 'package:checkly/components/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

showTextFieldDialog({context, title, label, onPress, textFieldController}) {
  // CollectionReference test = FirebaseFirestore.instance.collection("test");
  
  // final _textFieldController = TextEditingController();
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          scrollable: true,
          title: Center(child: Text(title)),
          content: Container(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: TextFormField(
                controller: textFieldController,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  labelText: label,
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    decorationColor: Color.fromRGBO(32, 227, 178, 1),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPrimary: Colors.white,
                  padding: EdgeInsets.all(0),
                  primary: Color.fromRGBO(32, 227, 178, 1),
                ),
                child: Text("Add"),
                onPressed: onPress)
                //     () {
                //   test.add({'name': _textFieldController.text});
                //   Navigator.pop(context, false);
                // })
          ],
        );
      });
}
Widget setupAlertDialoadContainer() {
  return Container(
    height: 300.0, // Change as per your requirement
    // width: 300.0, // Change as per your requirement
    child: ListView.builder(
      shrinkWrap: true,
      itemCount:  TaskColor.keys.length,
      itemBuilder: (BuildContext context, int index) {
        var colors = TaskColor.keys.toList();
        return ColorBox(color: colors[index]);
      },
    ),
  );
}

showAddTextFieldDialogColor({context, title, label, onPress, textFieldController}) {
  // CollectionReference test = FirebaseFirestore.instance.collection("test");
  // final _textFieldController = TextEditingController();
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          scrollable: true,
          title: Center(child: Text(title)),
          content:Container(
            width: 300,
            height: 175,
            child:Column(
              children: [
                Form(
                  child: TextFormField(
                    controller: textFieldController,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      labelText: label,
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        decorationColor: Color.fromRGBO(32, 227, 178, 1),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                GridView.builder(
                  shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                    ),
                    itemCount: TaskColor.keys.length,
                    itemBuilder: (BuildContext context, int index) {
                      var colors = TaskColor.keys.toList();
                      return ColorBox(color: colors[index]);
                    }),
                // ListView.builder(
                //     shrinkWrap: true,
                //     itemCount: TaskColor.keys.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       var colors = TaskColor.keys.toList();
                //       return ColorBox(color: colors[index]);
                //     }
                // )
              ],
            ),
          ),
          actions: [
            TextButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPrimary: Colors.white,
                  padding: EdgeInsets.all(0),
                  primary: Color.fromRGBO(32, 227, 178, 1),
                ),
                child: Text("Add"),
                onPressed: onPress)
            //     () {
            //   test.add({'name': _textFieldController.text});
            //   Navigator.pop(context, false);
            // })
          ],
        );
      });
}

showEditTextFieldDialog({context, title, initialText, label, onPress,textFieldController}) {
  // ignore: unused_local_variable
  CollectionReference test = FirebaseFirestore.instance.collection("test");

  // final _textFieldController = TextEditingController();
  textFieldController.text = initialText;
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          scrollable: true,
          title: Center(child: Text(title)),
          content: Container(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: TextFormField(
                controller: textFieldController,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    decorationColor: Color.fromRGBO(32, 227, 178, 1),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPrimary: Colors.white,
                  padding: EdgeInsets.all(0),
                  primary: Color.fromRGBO(32, 227, 178, 1),
                ),
                child: Text("Edit"),
                onPressed: onPress)
          ],
        );
      });
}

showConfirmationdDialog({context, title, label, onPress}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          scrollable: true,
          title: Text(title),
          content: Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(label),
          ),
          actions: [
            TextButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPrimary: Colors.white,
                  padding: EdgeInsets.all(0),
                  primary: Color.fromRGBO(32, 227, 178, 1),
                ),
                child: Text("Confirm"),
                onPressed: onPress),
            TextButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPrimary: Colors.white,
                  padding: EdgeInsets.all(0),
                  primary: Colors.red,
                ),
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        );
      });
}
