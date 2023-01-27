import 'package:flutter/material.dart';
import 'package:task_flutter_app/components/task.dart';

class TaskInherited extends InheritedWidget {
  TaskInherited({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final List<Task> taskList = [
     Task('Aprender Flutter', 'assets/images/flutter.png', 3),
     Task('Andar de Bike', 'assets/images/bike.jpg', 2),
     Task('Meditar na praia enquanto ouve as ondas do mar',
        'assets/images/meditation.jpeg', 5),
     Task('Ler', 'assets/images/book.jpg', 4),
     Task('Jogar', 'assets/images/playgame.jpg', 0),
  ];

  void newTask(String name, String photo, int difficulty){
    taskList.add(Task(name, photo, difficulty));
  }

  static TaskInherited of(BuildContext context) {
    final TaskInherited? result =
        context.dependOnInheritedWidgetOfExactType<TaskInherited>();
    assert(result != null, 'No TaskInherited found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TaskInherited oldWidget) {
    return oldWidget.taskList.length != taskList.length;
  }
}
