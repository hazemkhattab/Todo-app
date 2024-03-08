import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/settings_provider.dart';
import 'package:todo_app/features/task_bottom_sheet.dart';

class LayoutView extends StatelessWidget {
  static const String routeName = "layout";

  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<SettingsProvider>(context);
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => const TaskBottomSheet(),
          );
          // var data = TaskModel(
          //   title: "play football",
          //   description: "go to club",
          //   isDone: false,
          //   dateTime: DateTime.now(),
          // );
          // FirebaseUtils().addNewTask(data);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: vm.screens[vm.currentIndex],
      bottomNavigationBar: BottomAppBar(
        notchMargin: 12,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          currentIndex: vm.currentIndex,
          onTap: (index) {
            vm.changeIndex(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: "Tasks",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
