import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/taps/tasks/task_item.dart';

class TaskPage extends StatefulWidget {
  TaskPage({super.key});
  static String routName = 'task/';

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List<TaskModel> tasks = List.generate(
    10,
    (index) => TaskModel(
      title: 'title${index + 1}',
      description: 'desc${index + 1}',
      date: DateTime.now(),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          EasyInfiniteDateTimeLine(
            firstDate: DateTime.now().subtract(
              Duration(days: 365),
            ),
            focusDate: DateTime.now(),
            lastDate: DateTime.now().add(
              Duration(days: 365),
            ),
            showTimelineHeader: false,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 20),
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return TaskItem(
                  taskModel: tasks[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
