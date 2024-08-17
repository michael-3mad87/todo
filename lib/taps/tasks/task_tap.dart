import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_them.dart';
import 'package:todo/taps/tasks/task_item.dart';
import 'package:todo/taps/tasks/tasks_provider.dart';

class TaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    double screenHeight = MediaQuery.of(context).size.height;
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
                  activeColor: AppTheme.white,
                  
                  dayProps: EasyDayProps(
                    height: screenHeight*.11,
                    todayStyle : DayStyle(
                      decoration: BoxDecoration(
                        color: AppTheme.white ,
                        borderRadius: BorderRadius.circular(16)
                      ),
                      dayStrStyle: TextStyle(color: AppTheme.black),
                      monthStrStyle: TextStyle(color: Colors.transparent),
                    ),
                    activeDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: AppTheme.white ,
                        borderRadius: BorderRadius.circular(16)
                      ),
                      dayStrStyle: TextStyle(color: AppTheme.primaryColor),
                      dayNumStyle :Theme.of(context).textTheme.titleLarge?.copyWith(color: AppTheme.primaryColor),
                      monthStrStyle: TextStyle(color: Colors.transparent),
                    ),
                    inactiveDayStyle: DayStyle(
                      decoration: BoxDecoration(
                        color: AppTheme.white ,
                        borderRadius: BorderRadius.circular(16)
                      ),
                      dayStrStyle: TextStyle(color: AppTheme.black),
                      monthStrStyle: TextStyle(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ],
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
/*
class TaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * .15,
            color: Theme.of(context).primaryColor,
          ),
          PositionedDirectional(
            top: 50 ,
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
            padding: const EdgeInsets.only(top:100),
            child: EasyInfiniteDateTimeLine(
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
*/ 