import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_them.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/taps/tasks/task_edit.dart';
import 'package:todo/taps/tasks/tasks_provider.dart';

class TaskItem extends StatefulWidget {
  TaskItem({super.key, required this.taskModel , required this.index});
  TaskModel taskModel;
  int index; 

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isDone = false;

  @override
  void initState() {
    super.initState();
    isDone = widget.taskModel.isDone ?? false; 
  }

  void reflectDone() {
    setState(() {
      isDone = !isDone;
    });
  }
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, TaskEdit.routeName,
            arguments: tasksProvider.tasks[widget.index]);
      },
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(20),
        ),
        height: MediaQuery.of(context).size.height * .13,
        child: Row(
          children: [
            Container(
              color: isDone ? AppTheme.green : theme.primaryColor,
              width: 4,
              height: 62,
              margin: EdgeInsetsDirectional.only(end: 10),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.taskModel.title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: isDone? AppTheme.green :Theme.of(context).primaryColor,
                    )),
                Text(
                  
                  widget.taskModel.description,
                  style: theme.textTheme.titleSmall?.copyWith(fontSize: 16 ,color: isDone? AppTheme.green :Theme.of(context).primaryColor, ),
                )
              ],
            ),
            Spacer(),
             GestureDetector(
              onTap: reflectDone,
              child: isDone
                  ? Text(
                      'Done!',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: AppTheme.green,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      width: 36,
                      height: 36,
                      child: Icon(
                        Icons.check,
                        color: AppTheme.white,
                        size: 32,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}