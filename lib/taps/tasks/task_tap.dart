import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Auth/user_provider.dart';
import 'package:todo/app_them.dart';
import 'package:todo/taps/tasks/task_item.dart';
import 'package:todo/taps/tasks/tasks_provider.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  bool getTasksForOnce = true;
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    final userId =
        Provider.of<UserProvider>(context, listen: false).currentUser!.id;
    double screenHeight = MediaQuery.of(context).size.height;
    if (getTasksForOnce) {
      tasksProvider.getAllTasks(userId);
      getTasksForOnce = false;
    }
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: screenHeight * .15,
                color: Theme.of(context).primaryColor,
              ),
              PositionedDirectional(
                top: 40,
                start: 20,
                child: Text(
                  'ToDo list',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: AppTheme.white, fontSize: 22),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * .1),
                child: EasyInfiniteDateTimeLine(
                  firstDate: DateTime.now().subtract(
                    const Duration(days: 365),
                  ),
                  focusDate: tasksProvider.selectedDate,
                  lastDate: DateTime.now().add(
                    const Duration(days: 365),
                  ),
                  showTimelineHeader: false,
                  onDateChange: (selectedDate) {
                    tasksProvider.changeSelectedDate(selectedDate);
                    tasksProvider.getAllTasks(userId);
                  },
                  activeColor: AppTheme.white,
                  dayProps: EasyDayProps(
                    height: screenHeight * .11,
                    todayStyle: DayStyle(
                      decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.circular(16)),
                      dayStrStyle: TextStyle(color: AppTheme.black),
                      monthStrStyle: const TextStyle(color: Colors.transparent),
                    ),
                    activeDayStyle: DayStyle(
                      decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.circular(16)),
                      dayStrStyle: TextStyle(color: AppTheme.primaryColor),
                      dayNumStyle: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: AppTheme.primaryColor),
                      monthStrStyle: const TextStyle(color: Colors.transparent),
                    ),
                    inactiveDayStyle: DayStyle(
                      decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.circular(16)),
                      dayStrStyle: TextStyle(color: AppTheme.black),
                      monthStrStyle: const TextStyle(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 20),
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
