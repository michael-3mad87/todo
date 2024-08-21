import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo/Auth/login_screen.dart';
import 'package:todo/Auth/user_provider.dart';
import 'package:todo/app_them.dart';
import 'package:todo/firebase_function.dart';
import 'package:todo/taps/setting/setting_provider.dart';
import 'package:todo/taps/tasks/tasks_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});
  static String routName = 'setting/';

  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
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
                'Setting',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: settingProvider.themMode == ThemeMode.light
                        ? AppTheme.white
                        : AppTheme.darktItem,
                    fontSize: 22),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'LogOut',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: settingProvider.themMode == ThemeMode.light
                              ? AppTheme.darktItem
                              : AppTheme.white,
                        ),
                  ),
                  IconButton(
                    onPressed: () {
                      FirebaseFunctions.logout();
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                      Provider.of<TasksProvider>(context, listen: false)
                          .tasks
                          .clear();
                      Provider.of<UserProvider>(context, listen: false)
                          .currentUser = null;
                    },
                    icon: Icon(
                      Icons.logout_outlined,
                      size: 28,
                      color: settingProvider.themMode == ThemeMode.light
                          ? AppTheme.darktItem
                          : AppTheme.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dark mode",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: settingProvider.themMode == ThemeMode.light
                              ? AppTheme.darktItem
                              : AppTheme.white,
                        ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    value: settingProvider.themMode == ThemeMode.dark
                        ? 'Dark'
                        : 'Light',
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        ThemeMode selectedTheme = newValue == 'Dark'
                            ? ThemeMode.dark
                            : ThemeMode.light;
                        settingProvider.changeTheme(selectedTheme);
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    items: <String>['Light', 'Dark']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: settingProvider.themMode == ThemeMode.light
                                ? AppTheme.darktItem
                                : AppTheme.white,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Language',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: settingProvider.themMode == ThemeMode.light
                              ? AppTheme.darktItem
                              : AppTheme.white,
                        ),
                  ),
                  SizedBox(height: 20,),
                  DropdownButtonFormField<String>(
                    value: settingProvider.language,
                    onChanged: (String? selectedLanguage) {
                      if (selectedLanguage != null) {
                        settingProvider.changeLanguage(selectedLanguage);
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'en',
                        child: Text(
                          "English",
                          style: TextStyle(
                            color: settingProvider.themMode == ThemeMode.light
                                ? AppTheme.darktBlack
                                : AppTheme.white,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'ar',
                        child: Text(
                          "العربية",
                          style: TextStyle(
                            color: settingProvider.themMode == ThemeMode.light
                                ? AppTheme.darktBlack
                                : AppTheme.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
