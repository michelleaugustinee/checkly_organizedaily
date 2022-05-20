import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditModeFunction{
  deleteTopicFirestore(id, index, length, snapshot, collectionRef){
    _deleteTopicTask(id);
    for(int i = index + 1; i < length; i++){
      String id = snapshot.data!.docs[i].id;
      collectionRef.doc(id).update({'OrderIndex': i-1});
    }

  }

  _deleteTopicTask(id)async{
    Stream<QuerySnapshot> tasks = await FirebaseFirestore.instance.collection("Tasks").where("TopicID", isEqualTo: id).snapshots();
    CollectionReference taskCollection = FirebaseFirestore.instance.collection("Tasks");
    
   tasks.forEach((element) {
     element.docs.forEach((e) {
       taskCollection.doc(e.id).delete();
     });
   });


  }

  deleteTaskFirestore(index, length, snapshot, collectionRef){
    for(int i = index + 1; i < length; i++){
      String id = snapshot.data!.docs[i].id;
      collectionRef.doc(id).update({'OrderIndex': i-1});
    }
  }
}
