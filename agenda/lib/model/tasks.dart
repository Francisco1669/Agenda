import 'package:agenda/widgets/task.dart';
import 'package:flutter/material.dart';

class Tasks extends ChangeNotifier {
  List<Task> tasks;

  Tasks({this.tasks = const []});

  void addTask(Task task) {
    tasks.add(task);
    notifyListeners();
  }
}
