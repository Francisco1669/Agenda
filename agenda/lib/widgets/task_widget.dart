import 'package:agenda/theme/palette.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TaskWidget extends StatefulWidget {
  final String tarefa;
  DateTime date;
  TaskWidget({super.key, required this.tarefa, required this.date});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, constraints) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          color: Palette.lightGrey,
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.delete_sweep,
                color: Palette.closeRed,
                size: 24,
              ),
              Text(
                widget.tarefa,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 16),
              ),
              const Icon(
                Icons.book,
                color: Palette.colorPri,
                size: 24,
              ),
            ],
          ),
        );
      },
    );
  }
}
