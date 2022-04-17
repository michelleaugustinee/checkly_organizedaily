import 'package:flutter/material.dart';

class ReorderableListViewCheckly{

  onReorder(oldIndex,  newIndex, items){
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final dynamic item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
  }

  proxyDecorator(child) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          // color: Color.fromRGBO(41, 255, 198, 1),
          boxShadow: [ //background color of box
            BoxShadow(
              color: Color.fromRGBO(12, 235, 235, 1),
              blurRadius: 10.0, // soften the shadow
              spreadRadius: 2.0, //extend the shadow
            )
          ],
        ),
        child: child,
      ),
    );
  }
}