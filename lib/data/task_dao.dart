// ignore_for_file: prefer_final_fields

import 'package:agenda/data/database.dart';
import 'package:agenda/model/task.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_name TEXT)';
  static const String _tableName = 'taskTable';
  static const String _name = 'nome';
  static var _creationDate = 'dataCriacao';

  save(Task tarefa) async {
    final Database bancoDados = await getDatabase();
    var itemExists = await find(tarefa.title);
    Map<String, dynamic> taskMap = toMap(tarefa);
    if (itemExists.isEmpty) {
      return await bancoDados.insert(_tableName, taskMap);
    } else {
      return await bancoDados.update(_tableName, taskMap,
          where: '$_name = ?', whereArgs: [tarefa.title]);
    }
  }

  Map<String, dynamic> toMap(Task tarefa) {
    final Map<String, dynamic> mapaTarefa = {};
    mapaTarefa[_name] = tarefa.title;
    mapaTarefa[_creationDate] = tarefa.creationDate;
    return mapaTarefa;
  }

  Future<List<Task>> findAll() async {
    final Database bancoDados = await getDatabase();
    final List<Map<String, dynamic>> result =
        await bancoDados.query(_tableName);

    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> mapaTarefas) {
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in mapaTarefas) {
      final Task tarefa =
          Task(title: linha[_name], creationDate: linha[_creationDate]);
      tarefas.add(tarefa);
    }
    return tarefas;
  }

  Future<List<Task>> find(String nomeTarefa) async {
    final Database bancoDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDados
        .query(_tableName, where: '$_name = ?', whereArgs: [nomeTarefa]);
    return toList(result);
  }

  delete(String nomeTarefa) async {
    final Database bancoDados = await getDatabase();
    return bancoDados
        .delete(_tableName, where: '$_name = ?', whereArgs: [nomeTarefa]);
  }
}
