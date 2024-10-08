import 'package:flutter/material.dart';
import 'package:todo/taps/setting/setting_tap.dart';
import 'package:todo/taps/tasks/task_bottom_sheet.dart';
import 'package:todo/taps/tasks/task_tap.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String routName = 'home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTapIndex = 0;
  List<Widget> tabs = [
    const TaskPage(),
    const SettingPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentTapIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: BottomNavigationBar(
          currentIndex: currentTapIndex,
          onTap: (value) {
            currentTapIndex = value;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  size: 35,
                ),
                label: 'tasks'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_outlined,
                  size: 35,
                ),
                label: 'setting'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => const AddTaskBottomSheet(),
        ),
        child: const Icon(
          Icons.add,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
