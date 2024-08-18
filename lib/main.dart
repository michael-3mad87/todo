import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Auth/login_screen.dart';
import 'package:todo/Auth/register_screen.dart';
import 'package:todo/app_them.dart';
import 'package:todo/home_page.dart';
import 'package:todo/taps/tasks/task_edit.dart';
import 'package:todo/taps/tasks/tasks_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();
  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp(
    ChangeNotifierProvider(
      create: (_) => TasksProvider()..getAllTasks(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomePage.routName: (_) => const HomePage(),
        TaskEdit.routeName: (_) => const TaskEdit(),
        RegisterScreen.routeName: (_) => const RegisterScreen(),
        LoginScreen.routeName:(_)=>const LoginScreen() ,
      },
      initialRoute: LoginScreen.routeName ,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
