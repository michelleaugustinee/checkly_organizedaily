import 'package:flutter/material.dart';

class Todo {
  DateTime createdTime;
  String title;

  Todo({
    required this.createdTime,
    required this.title,
  });
}

List<Todo> todos = [
  Todo(
    createdTime: DateTime.now(), 
    title: 'Rapat1',
  ),
  Todo(
    createdTime: DateTime.now(), 
    title: 'Rapat',
  ),
  Todo(
    createdTime: DateTime.now(), 
    title: 'Rapat',
  ),
];