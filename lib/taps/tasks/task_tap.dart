import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/taps/tasks/task_item.dart';
import 'package:todo/taps/tasks/tasks_provider.dart';

class TaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
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
            focusDate: tasksProvider.selectedDate,
            lastDate: DateTime.now().add(
              Duration(days: 365),
            ),
            showTimelineHeader: false,
            onDateChange: (selectedDate) {
              tasksProvider.changeSelectedDate(selectedDate);
              tasksProvider.getAllTasks();
            },
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 20),
              itemCount: tasksProvider.tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return TaskItem(
                  taskModel: tasksProvider.tasks[index],
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
