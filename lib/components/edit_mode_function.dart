import 'package:flutter/material.dart';

class EditModeFunction{
  deleteReoderFirestore(index, length, snapshot, collectionRef){

    for(int i = index + 1; i < length; i++){
      String id = snapshot.data!.docs[i].id;
      collectionRef.doc(id).update({'OrderIndex': i-1});
    }
  }

}
