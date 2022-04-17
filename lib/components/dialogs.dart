import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

showTextFieldDialog({context, title, label, onPress}) {
  CollectionReference test = FirebaseFirestore.instance.collection("test");

  final _textFieldController = TextEditingController();
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
                controller: _textFieldController,
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
                onPressed: () {
                  test.add({'name': _textFieldController.text});
                  Navigator.pop(context, false);
                })
          ],
        );
      });
}

showEditTextFieldDialog({context, title, initialText, label, onPress}) {
  // ignore: unused_local_variable
  CollectionReference test = FirebaseFirestore.instance.collection("test");

  final _textFieldController = TextEditingController();
  _textFieldController.text = initialText;
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
                controller: _textFieldController,
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
