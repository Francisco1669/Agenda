// ignore: file_names
// ignore: file_names
import 'package:agenda/model/tasks.dart';
import 'package:agenda/theme/palette.dart';
import 'package:agenda/widgets/appbar.dart';
import 'package:agenda/widgets/drawer.dart';
import 'package:agenda/widgets/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  TextEditingController taskNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, constraints) {
        return Scaffold(
          drawer: const MyDrawer(),
          appBar: PreferredSize(
              preferredSize: Size(
                  constraints.maxWidth * 0.1, constraints.maxHeight * 0.075),
              child: const DefaultBar()),
          body: Consumer<Tasks>(
            builder: (BuildContext context, Tasks list, _) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: list.tasks.length,
                itemBuilder: (context, index) {
                  final listItem = list.tasks[index];
                  return Dismissible(
                    key: ValueKey<Task>(list.tasks[index]),
                    secondaryBackground: Container(
                      color: Palette.doneGreen,
                      child: const Icon(Icons.done, color: Palette.whiteColor),
                    ),
                    background: Container(
                      color: Palette.closeRed,
                      child: const Icon(
                        Icons.delete,
                        color: Palette.whiteColor,
                      ),
                    ),
                    onDismissed: ((DismissDirection direction) {
                      setState(() {
                        final int index = list.tasks.indexOf(listItem);
                        list.tasks.removeAt(index);
                      });
                    }),
                    child: Task(tarefa: listItem.tarefa),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
