
class Topic{
  final int? id;
  final String TopicName;
  final int OrderIndex;

  Topic({
    this.id,
    required this.OrderIndex,
    required this.TopicName
  });

  Map<String, dynamic> toMap(){
    return{
      'ID': id,
      'TopicName': TopicName,
      'OrderIndex': OrderIndex,
    };
  }
  factory Topic.fromMap(Map<String, dynamic> json) => Topic(
    id: json['ID'],
    TopicName: json['TopicName'],
    OrderIndex: json['OrderIndex'],
  );
}

class Task{
  final int? id;
  final String TasksName;
  final int OrderIndex;
  final int Status;
  final String Color;
  final String TopicID;

  Task({
    this.id,
    required this.OrderIndex,
    required this.TasksName,
    required this.Status,
    required this.Color,
    required this.TopicID,
  });

  Map<String, dynamic> toMap(){
    return{
      'ID': id,
      'OrderIndex': OrderIndex,
      'TaskName': TasksName,
      'Status': Status,
      'Color': Color,
      'TopicID': TopicID,
    };
  }
  factory Task.fromMap(Map<String, dynamic> json) => Task(
    id: json['ID'],
    TasksName: json['TaskName'],
    OrderIndex: json['OrderIndex'],
    Status: json['Status'],
    Color: json['Color'],
    TopicID: json['TopicID']
  );
}
