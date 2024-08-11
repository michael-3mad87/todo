import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/app_them.dart';
import 'package:todo/home_page.dart';
import 'package:todo/taps/tasks/task_tap.dart';
import 'package:todo/taps/setting/setting_tap.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        TaskPage.routName: (_) => TaskPage(),
        SettingPage.routName: (_) => SettingPage(),
        HomePage.routName:(_) => HomePage(),
      },
      initialRoute: HomePage.routName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
