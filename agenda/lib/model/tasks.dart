import 'package:agenda/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Tasks extends ChangeNotifier {
  List<TaskWidget> tasks = [];

  Map<String, dynamic> toMap() {
    return {};
  }

  void addTask(TaskWidget task) {
    tasks.add(task);
    notifyListeners();
  }

  List<TaskWidget> getTasksForDate(DateTime date) {
    return tasks.where((task) => isSameDay(task.dataCriacao, date)).toList();
  }
}
