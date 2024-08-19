import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Auth/login_screen.dart';
import 'package:todo/Auth/user_provider.dart';
import 'package:todo/firebase_function.dart';
import 'package:todo/taps/tasks/tasks_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});
  static String routName = 'setting/';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'LogOut',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                onPressed: () {
                  FirebaseFunctions.logout();
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                  Provider.of<TasksProvider>(context , listen: false).tasks.clear();
                   Provider.of<UserProvider>(context , listen: false).currentUser=null;
                },
                icon: const Icon(
                  Icons.logout_outlined,
                  size: 28,
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
