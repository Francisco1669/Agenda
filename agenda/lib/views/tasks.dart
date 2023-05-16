import 'package:agenda/model/task_model.dart';
import 'package:agenda/theme/palette.dart';
import 'package:agenda/widgets/drawer.dart';
import 'package:agenda/widgets/task.dart';
import 'package:flutter/material.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  TextEditingController taskNameController = TextEditingController();
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    List<TaskModel> listaTarefas = [
      TaskModel("Estudar ingles"),
      TaskModel("Varrer a casa"),
      TaskModel("Ir a academia"),
      TaskModel("Realizar a leitura"),
    ];

    return LayoutBuilder(
      builder: (BuildContext context, constraints) {
        return Scaffold(
          drawer: const MyDrawer(),
          appBar: AppBar(
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
                          height: constraints.maxHeight * 0.2,
                          child: Column(
                            children: [
                              TextField(
                                controller: taskNameController,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.task),
                                    hintText: "Limpar o quarto",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    fillColor: Palette.colorPri,
                                    focusColor: Palette.colorPri),
                              ),
                              SizedBox(
                                height: constraints.maxHeight * 0.025,
                              ),
                              // TextFormField(
                              //     decoration: const InputDecoration(
                              //         prefixIcon: Icon(Icons.timer),
                              //         hintText: "Horário da tarefa",
                              //         border: OutlineInputBorder(
                              //             borderRadius: BorderRadius.all(
                              //                 Radius.circular(12))),
                              //         fillColor: Palette.colorPri,
                              //         focusColor: Palette.colorPri))
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
                              ElevatedButton(
                                onPressed: () {
                                  TaskModel novaTarefa =
                                      TaskModel(taskNameController.text);
                                  listaTarefas.add(novaTarefa);
                                  Navigator.of(context).pop();
                                  setState(() {});
                                },
                                child: const Text('Adicionar'),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: listaTarefas.length,
                itemBuilder: (context, index) {
                  final listItem = listaTarefas[index];
                  return Dismissible(
                    key: ValueKey<TaskModel>(listaTarefas[index]),
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
                        final int index = listaTarefas.indexOf(listItem);
                        listaTarefas.removeAt(index);
                      });
                    }),
                    child: Task(tarefa: listItem.task),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
