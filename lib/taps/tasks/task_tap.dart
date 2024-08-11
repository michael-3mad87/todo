import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo/taps/tasks/task_item.dart';

class TaskPage extends StatefulWidget {
  TaskPage({super.key});
  static String routName = 'task/';

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  List task = List.generate(10, (index) => null);
  // final EasyInfiniteDateTimelineController _controller =
  //     EasyInfiniteDateTimelineController();
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
              itemCount: 15,
              itemBuilder: (BuildContext context, int index) {
                return TaskItem();
              },
            ),
          ),
        ],
      ),
    );
  }
}
