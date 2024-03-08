import 'package:flutter/material.dart';
import 'package:todo_app/features/settings/page/settings_view.dart';
import 'package:todo_app/features/tasks/page/tasks_view.dart';

class SettingsProvider extends ChangeNotifier {
  String currentLanguage = "en";

  ThemeMode currentThemeMode = ThemeMode.light;

  int currentIndex = 0;

  DateTime selectedDate = DateTime.now();

  List<Widget> screens = [
    const TasksView(),
    const SettingsView(),
  ];

  selectedTaskDate(BuildContext context) async {
    var currentSelectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      currentDate: DateTime.now(),
      initialDate: selectedDate,
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
    if (currentSelectedDate == null) return;
    selectedDate = currentSelectedDate;
    notifyListeners();
  }

  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  changeTheme(ThemeMode newTheme) {
    if (currentThemeMode == newTheme) return;
    currentThemeMode = newTheme;
    notifyListeners();
  }

  changeLanguage(String newLanguage) {
    if (currentLanguage == newLanguage) return;
    currentLanguage = newLanguage;
    notifyListeners();
  }

  bool isDark() {
    return currentThemeMode == ThemeMode.dark;
  }
}
