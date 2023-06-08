import 'package:agenda/model/tasks.dart';
import 'package:agenda/theme/palette.dart';
import 'package:agenda/widgets/drawer.dart';
import 'package:agenda/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

var now = DateTime.now();
var firstDay = DateTime(now.year, now.month - 3, now.day);
var lastDay = DateTime(now.year, now.month + 3, now.day);
CalendarFormat format = CalendarFormat.week;

var focusedDay = DateTime.now();
var selectedDay = DateTime.now();

bool load = false;
List<Tasks> taskss = [];

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  TextEditingController taskNameController = TextEditingController();

  Map<DateTime, List<TaskWidget>> tasksSelected = {};

  List<TaskWidget> _getTasksfromDay(DateTime date) {
    final tasksProvider = Provider.of<Tasks>(context);
    return tasksProvider.getTasksForDate(date);
  }

  @override
  void initState() {
    tasksSelected = {};
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    taskNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, constraints) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
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
                              child: const Text(
                                'Fechar',
                                style: TextStyle(color: Palette.closeRed),
                              ),
                            ),
                            Consumer<Tasks>(
                              builder: (BuildContext context, Tasks list, _) {
                                return ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Palette.colorSec)),
                                  onPressed: () {
                                    if (taskNameController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          action: SnackBarAction(
                                              label: 'Desfazer',
                                              onPressed: () {}),
                                          content: Text(
                                            'Este campo não pode ser nulo',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: Palette.whiteColor),
                                          ),
                                        ),
                                      );
                                    } else {
                                      TaskWidget novaTarefa = TaskWidget(
                                        tarefa: taskNameController.text,
                                        dataCriacao: selectedDay,
                                      );
                                      list.addTask(
                                        novaTarefa,
                                      ); // Passa a data selecionada
                                      Navigator.of(context).pop();
                                    }
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
              child: (const Icon(Icons.add))),
          drawer: const MyDrawer(),
          appBar: AppBar(
            title: const Text('Agenda'),
          ),
          body: Column(
            children: [
              TableCalendar(
                eventLoader: _getTasksfromDay,
                onDaySelected: (newSelectedDay, newFocusedDay) {
                  setState(() {
                    selectedDay = newSelectedDay;
                    focusedDay = newFocusedDay;
                  });
                },
                selectedDayPredicate: (day) => isSameDay(day, selectedDay),
                calendarStyle: const CalendarStyle(
                    selectedDecoration: BoxDecoration(
                        color: Palette.mediumGrey, shape: BoxShape.circle)),
                focusedDay: now,
                firstDay: firstDay,
                lastDay: lastDay,
                calendarFormat: format,
                startingDayOfWeek: StartingDayOfWeek.monday,
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Mes',
                  CalendarFormat.week: 'Semana',
                  CalendarFormat.twoWeeks: '2 semanas'
                },
                headerStyle: const HeaderStyle(
                    formatButtonShowsNext: false, formatButtonVisible: false),
              ),
              Consumer<Tasks>(
                builder: (BuildContext context, Tasks tasksProvider, _) {
                  final tasksForSelectedDay =
                      tasksProvider.getTasksForDate(selectedDay);
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: tasksForSelectedDay.length,
                    itemBuilder: (context, index) {
                      final listItem = tasksForSelectedDay[index];
                      return Consumer(
                          builder: (BuildContext context, Tasks list, child) {
                        return Dismissible(
                          key: ValueKey<TaskWidget>(list.tasks[index]),
                          secondaryBackground: Container(
                            color: Palette.doneGreen,
                            child: const Icon(Icons.done,
                                color: Palette.whiteColor),
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
                          child: TaskWidget(
                            tarefa: listItem.tarefa,
                            dataCriacao: DateTime.now(),
                          ),
                        );
                      });
                    },
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
