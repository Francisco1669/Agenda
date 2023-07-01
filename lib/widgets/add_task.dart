import 'package:agenda/Controller/tasks_controller.dart';
import 'package:agenda/model/task.dart';
import 'package:agenda/theme/palette.dart';
import 'package:agenda/views/tasks_view.dart';
import 'package:agenda/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTask extends StatelessWidget {
  const AddTask({
    Key? key,
    required this.taskNameController,
  }) : super(key: key);

  final TextEditingController taskNameController;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Palette.colorPri,
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
                    TextFormField(
                      controller: taskNameController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.task),
                        hintText: "Limpar o quarto",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        fillColor: Palette.colorPri,
                        focusColor: Palette.colorPri,
                      ),
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
                      child: const Text(
                        'Fechar',
                        style: TextStyle(color: Palette.closeRed),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (taskNameController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              action: SnackBarAction(
                                label: 'Desfazer',
                                onPressed: () {},
                              ),
                              content: Text(
                                'Este campo não pode ser nulo',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Palette.whiteColor),
                              ),
                            ),
                          );
                        } else {
                          Task task = Task(
                            title: taskNameController.text,
                            creationDate: selectedDay,
                          );
                          TaskWidget novaTarefa = TaskWidget(
                            tarefa: task.title,
                            dataCriacao: task.creationDate,
                          );
                          Provider.of<Tasks>(context, listen: false).addTask(
                            novaTarefa,
                          ); // Passa a data selecionada
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Adicionar'),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
