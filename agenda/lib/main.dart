import 'package:agenda/model/tasks.dart';
import 'package:agenda/views/done_tasks.dart';
import 'package:agenda/views/initialPage.dart';
import 'package:agenda/widgets/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: ((context) => Tasks(tasks: [])),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const InitialPage(),
          '/tasksDone': (context) => const DoneTasks()
        },
        title: 'ToDo List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.purple,
          ),
        ));
  }
}
