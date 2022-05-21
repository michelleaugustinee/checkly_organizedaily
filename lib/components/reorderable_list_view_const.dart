import 'package:checkly/utils/database_provider.dart';
import 'package:flutter/material.dart';

class ReorderableListViewCheckly{

  onReorder(oldIndex,  newIndex, items){
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final dynamic item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
  }
  onReorderFireStore(oldIndex, newIndex, snapshot, collectionRef){
    if(newIndex > oldIndex){
      for(int i = oldIndex + 1; i < newIndex; i++){
        String id = snapshot.data!.docs[i].id;
        collectionRef.doc(id).update({'OrderIndex': i-1});
      }
      String id = snapshot.data!.docs[oldIndex].id;
      collectionRef.doc(id).update({'OrderIndex': newIndex-1});
    }else{
      for(int i = oldIndex - 1; i >= newIndex; i--){
        String id = snapshot.data!.docs[i].id;
        collectionRef.doc(id).update({'OrderIndex': i+1});
      }
      String id = snapshot.data!.docs[oldIndex].id;
      collectionRef.doc(id).update({'OrderIndex': newIndex});
    }
  }

  onReorderTopicLocal(oldIndex, newIndex, snapshot){
    if(newIndex > oldIndex){
      for(int i = oldIndex + 1; i < newIndex; i++){
        int id = snapshot.data.elementAt(i).id;
        dbHelper.instance.reoderTopic(id, i-1);
      }
      int id = snapshot.data.elementAt(oldIndex).id;
      dbHelper.instance.reoderTopic(id, newIndex-1);
    }else{
      for(int i = oldIndex - 1; i >= newIndex; i--){
        int id = snapshot.data.elementAt(i).id;
        dbHelper.instance.reoderTopic(id, i+1);
      }
      int id = snapshot.data.elementAt(oldIndex).id;
      dbHelper.instance.reoderTopic(id, newIndex);
    }
  }

  onReorderTaskLocal(oldIndex, newIndex, snapshot){
    if(newIndex > oldIndex){
      for(int i = oldIndex + 1; i < newIndex; i++){
        int id = snapshot.data.elementAt(i).id;
        dbHelper.instance.reoderTask(id, i-1);
      }
      int id = snapshot.data.elementAt(oldIndex).id;
      dbHelper.instance.reoderTask(id, newIndex-1);
    }else{
      for(int i = oldIndex - 1; i >= newIndex; i--){
        int id = snapshot.data.elementAt(i).id;
        dbHelper.instance.reoderTask(id, i+1);
      }
      int id = snapshot.data.elementAt(oldIndex).id;
      dbHelper.instance.reoderTask(id, newIndex);
    }
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