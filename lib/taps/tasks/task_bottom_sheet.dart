import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_them.dart';
import 'package:todo/firebase_function.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/taps/tasks/custom_button.dart';
import 'package:todo/taps/tasks/tasks_provider.dart';
import 'package:todo/taps/tasks/text_form_field.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  DateTime selectedTime = DateTime.now();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        height: MediaQuery.of(context).size.height * .55,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Add new task",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: AppTheme.black),
            ),
            SizedBox(
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
            SizedBox(
              height: 14,
            ),
            CustomTextFormField(
              controller: descriptionController,
              hintText: 'Enter task description',
              maxlines: 4,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter description';
                }
                return null;
              },
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              'select time ',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
            ),
            SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () async {
                DateTime? dateTime = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(
                      Duration(days: 365),
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
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              label: 'Save',
              onpressed: () {
                if (formKey.currentState!.validate()) {
                  addTask();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void addTask() {
    FirebaseFunctions.addTasksToFireStore(
      TaskModel(
        title: titleController.text,
        description: descriptionController.text,
        date: selectedTime,
      ),
    ).timeout(Duration(microseconds: 500), onTimeout: () {
      Navigator.of(context).pop();
      Provider.of<TasksProvider>(context , listen: false).getAllTasks();
      print('taskAded');
    }).catchError((e) {
      print('Error${e}');
    });
  }
}
/* 
when you just access or call from provider method or variable listen must be false , when you get data by default true 
*/