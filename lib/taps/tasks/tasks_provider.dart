import 'package:flutter/material.dart';
import 'package:todo/firebase_function.dart';
import 'package:todo/models/task_model.dart';

class TasksProvider extends ChangeNotifier {
  List<TaskModel> tasks = [];
  DateTime selectedDate = DateTime.now();
  Future<void> getAllTasks() async {
    //make filter by date using where
    List<TaskModel> allTasks = await FirebaseFunctions.getTasksFromFireStore();
    tasks = allTasks
        .where(
          (task) =>
              task.date.day == selectedDate.day &&
              task.date.month == selectedDate.month &&
              task.date.year == selectedDate.year,
        )
        .toList();
    notifyListeners();
  }

  void changeSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  Future<void> getUpdate(String id, TaskModel taskModel) async {
    await FirebaseFunctions.updateTaskInFireStore(id, taskModel);
    notifyListeners();
  }
}
