import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String title;
  String description;
  DateTime date;
  bool? isDone;
  String id;
  TaskModel({
    this.id ='' ,
    required this.title,
    required this.description,
    this.isDone = false,
    required this.date,
  });
  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
          id :json['id'] ,
          title: json['title'],
          description: json['description'],
          date: (json['date'] as Timestamp).toDate(),
          isDone: json['isDone'],
        );
  Map<String, dynamic> toJson() => {
        'id':id ,
        'title': title,
        'description': description,
        'date': Timestamp.fromDate(date),
        'isDone': isDone,
      };
}
