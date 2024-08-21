import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';
import 'package:todo/Auth/user_provider.dart';
import 'package:todo/app_them.dart';
import 'package:todo/firebase_function.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/taps/setting/setting_provider.dart';
import 'package:todo/taps/tasks/task_edit.dart';
import 'package:todo/taps/tasks/tasks_provider.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.taskModel,
    required this.index,
  });
 final TaskModel taskModel;
 final int index;

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
        SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Slidable(
        key: const ValueKey(0),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                deleteTask(context);
              },
              backgroundColor: AppTheme.red,
              foregroundColor: AppTheme.white,
              borderRadius: BorderRadius.circular(20),
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, TaskEdit.routeName,
                arguments: tasksProvider.tasks[widget.index]);
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: settingProvider.themMode == ThemeMode.light
                          ? AppTheme.white
                          : AppTheme.darktItem,
              borderRadius: BorderRadius.circular(20),
            ),
            height: MediaQuery.of(context).size.height * .13,
            child: Row(
              children: [
                Container(
                  color: isDone ? AppTheme.green : theme.primaryColor,
                  width: 4,
                  height: 62,
                  margin: const EdgeInsetsDirectional.only(end: 10),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.taskModel.title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: isDone
                              ? AppTheme.green
                              : Theme.of(context).primaryColor,
                        )),
                    Text(
                      widget.taskModel.description,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontSize: 16,
                        color: isDone
                            ? AppTheme.green
                            : Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
                const Spacer(),
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
        ),
      ),
    );
  }

  void deleteTask(BuildContext context) {
       final userId = Provider.of<UserProvider>(context, listen: false).currentUser!.id;
    FirebaseFunctions.deleteTaskFromFireStore(widget.taskModel.id ,  userId)
        .then( (_) {
      Provider.of<TasksProvider>(context, listen: false).getAllTasks(userId);
      isDone = false;
    }).catchError((e) {
      Fluttertoast.showToast(
          msg: "Something wrong",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: AppTheme.white,
          fontSize: 16.0);
    });
  }
}
