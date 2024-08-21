import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/Auth/user_provider.dart';
import 'package:todo/app_them.dart';
import 'package:todo/firebase_function.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/taps/setting/setting_provider.dart';
import 'package:todo/taps/tasks/custom_button.dart';
import 'package:todo/taps/tasks/tasks_provider.dart';
import 'package:todo/taps/tasks/text_form_field.dart';

class TaskEdit extends StatefulWidget {
  static String routeName = '/taskedit';
  const TaskEdit({super.key});

  @override
  State<TaskEdit> createState() => _TaskEditState();
}

class _TaskEditState extends State<TaskEdit> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  DateTime selectedTime = DateTime.now();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  final formKey = GlobalKey<FormState>();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    TaskModel args = ModalRoute.of(context)!.settings.arguments as TaskModel;
    titleController = TextEditingController(text: args.title);
    descriptionController = TextEditingController(text: args.description);
    selectedTime = args.date;
  }

  @override
  Widget build(BuildContext context) {
    TaskModel args = ModalRoute.of(context)!.settings.arguments as TaskModel;
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    return Scaffold(
      appBar: AppBar( iconTheme: IconThemeData(
          color: settingProvider.themMode == ThemeMode.light
                    ? AppTheme.darktItem
                    : AppTheme.white,
        ),),
      body: Center(
        child: SafeArea(
          child: Container(
            
            height: MediaQuery.of(context).size.height * .7,
            width: MediaQuery.of(context).size.width * .9,
            decoration: BoxDecoration(color: settingProvider.themMode == ThemeMode.light
                          ? AppTheme.white
                          : AppTheme.darktItem, ),
            child: Form(
              key: formKey,
              child: Container(
                height: MediaQuery.of(context).size.height * .55,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      " Edit task",
                      style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: settingProvider.themMode == ThemeMode.light
                          ? AppTheme.darktItem
                          : AppTheme.white,),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    CustomTextFormField(
                      controller: titleController,
                      hintText: 'Enter task title',
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter title';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    CustomTextFormField(
                      controller: descriptionController,
                      hintText: 'Enter task description',
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Text(
                      'select time ',
                      style:  Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                      color: settingProvider.themMode == ThemeMode.light
                          ? AppTheme.darktItem
                          : AppTheme.white,
                  ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      onTap: () async {
                        DateTime? dateTime = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                            initialEntryMode: DatePickerEntryMode.calendarOnly,
                            initialDate: selectedTime);
                        if (dateTime != null) {
                          selectedTime = dateTime;
                          setState(() {});
                        }
                      },
                      child: Text(
                        dateFormat.format(selectedTime),
                        style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold , color: settingProvider.themMode == ThemeMode.light
                          ? AppTheme.darktItem
                          : AppTheme.white, ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      label: 'Save Changes',
                      oppressed: () async {
                        if (formKey.currentState!.validate()) {
                          taskUpdated(args.id);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void taskUpdated(String id) {
    final userId =
        Provider.of<UserProvider>(context, listen: false).currentUser!.id;
    TaskModel updatedTask = TaskModel(
      id: id,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      date: selectedTime,
    );
    FirebaseFunctions.updateTaskInFireStore(id, updatedTask, userId).then((_) {
      Navigator.of(context).pop();
      Provider.of<TasksProvider>(context, listen: false).getAllTasks(userId);
      Fluttertoast.showToast(
          msg: "Task updated successfully",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
          backgroundColor: AppTheme.green,
          textColor: AppTheme.white,
          fontSize: 16.0);
    }).catchError((e) {
      Fluttertoast.showToast(
          msg: "Something wrong",
          toastLength: Toast.LENGTH_LONG,
          timeInSecForIosWeb: 5,
          backgroundColor: AppTheme.red,
          textColor: AppTheme.white,
          fontSize: 16.0);
    });
  }
}
