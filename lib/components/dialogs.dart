import 'package:checkly/components/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

showTopicTextFieldDialog({context, title, initialText, label, onPress, textFieldController}) {
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
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  labelText: label,
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    decorationColor: Color.fromRGBO(32, 227, 178, 1),
                  ),
                ),
                maxLines: null,
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


class EditTaskTextFieldDialog extends StatefulWidget {

  final context;
  final title;
  final initialText;
  final initialColor;
  final label;
  final onPress;
  final textFieldController;

  EditTaskTextFieldDialog({
    required this.onPress,
    required this.title,
    required this.initialText,
    required this.initialColor,
    required this.context,
    required this.textFieldController,
    required this.label
  });

  @override
  _EditTaskTextFieldDialogState createState() => _EditTaskTextFieldDialogState();
}

class _EditTaskTextFieldDialogState extends State<EditTaskTextFieldDialog> {
  int selectedColor = -1;
  String color = "";
  String initialColor = "";
  @override
  void initState() {
    initialColor = widget.initialColor;
    widget.textFieldController.text = widget.initialText;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      scrollable: true,
      title: Center(child: Text(widget.title)),
      content:Container(
        // width: 300,
        // height: 175,
        child:Column(
          children: [
            Form(
              child: TextFormField(
                controller: widget.textFieldController,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  labelText: widget.label,
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    decorationColor: Color.fromRGBO(32, 227, 178, 1),
                  )
                ),
                maxLines: null,
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: 300,
              height: 50,
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                  ),
                  itemCount: TaskColor.keys.length,
                  itemBuilder: (BuildContext context, int index) {
                    var colors = TaskColor.keys.toList();
                    if(colors[index] == initialColor && selectedColor < 0){
                      selectedColor = index;
                      color = colors[selectedColor];
                    }
                    return GestureDetector(
                        onTap: (){
                          setState((){
                            selectedColor = index;
                            color = colors[selectedColor];
                          });
                        },
                        child: ColorBox(
                          color: colors[index],
                          selected: selectedColor == index? true : false,
                        )
                    );
                  }),
            ),
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
            child: Text("Edit"),
            onPressed: (){
              widget.onPress(color);
            }
        )
      ],
    );
  }
}

showTaskTextFieldDialog({context, title, initialText ,initialColor, label, onPress,textFieldController}){
  textFieldController.text = initialText;
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditTaskTextFieldDialog(
            onPress: onPress,
            title: title,
            initialText: initialText,
            initialColor: initialColor,
            context: context,
            textFieldController: textFieldController,
            label: label);
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
