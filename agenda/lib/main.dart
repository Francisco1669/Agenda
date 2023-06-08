import 'package:agenda/model/tasks.dart';
import 'package:agenda/theme/palette.dart';
import 'package:agenda/views/initial_page.dart';
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
        },
        title: 'ToDo List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
              centerTitle: true, backgroundColor: Palette.colorPri),
        ));
  }
}
