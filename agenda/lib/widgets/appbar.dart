import 'package:agenda/model/tasks.dart';
import 'package:agenda/theme/Palette.dart';
import 'package:agenda/views/initialPage.dart';
import 'package:agenda/widgets/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DefaultBar extends StatefulWidget {
  const DefaultBar({super.key});

  @override
  State<DefaultBar> createState() => _DefaultBarState();
}

class _DefaultBarState extends State<DefaultBar> {
  TextEditingController taskNameController = TextEditingController();
  late InitialPage initial;
  @override
  Widget build(BuildContext context) {
    Tasks tasksProvider = Provider.of<Tasks>(context, listen: true);
    return AppBar(
      title: const Text("Agenda"),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Criar atividade'),
                  content: SizedBox(
                    height: 130,
                    child: Column(
                      children: [
                        TextField(
                          controller: taskNameController,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.task),
                              hintText: "Limpar o quarto",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              fillColor: Palette.colorPri,
                              focusColor: Palette.colorPri),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Fechar'),
                        ),
                        Consumer<Tasks>(
                          builder: (BuildContext context, Tasks list, _) {
                            return ElevatedButton(
                              onPressed: () {
                                Task novaTarefa =
                                    Task(tarefa: taskNameController.text);
                                list.addTask(novaTarefa);
                                Navigator.of(context).pop();
                              },
                              child: const Text('Adicionar'),
                            );
                          },
                        )
                      ],
                    )
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
