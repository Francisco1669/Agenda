import 'package:agenda/widgets/task_widget.dart';
import 'package:flutter/material.dart';

class Tasks extends ChangeNotifier {
  List<TaskWidget> tasks;

  Tasks({this.tasks = const []});

  void addTask(TaskWidget task, DateTime date) {
    task.date = date;
    tasks.add(task);
    notifyListeners();
  }
}
