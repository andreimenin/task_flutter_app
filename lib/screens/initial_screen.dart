import 'package:flutter/material.dart';
import 'package:task_flutter_app/components/task.dart';
import 'package:task_flutter_app/data/task_inherited.dart';
import 'package:task_flutter_app/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //estrutura pronta de layout
      appBar: AppBar(
          leading: Container(color: Colors.black26),
          title: const Text('Tarefas')),
      body: ListView(
        children: TaskInherited.of(context).taskList,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (contextNew) => FormScreen(
                  taskContext: context,
                ),
              ),
            );
          },
          child: const Icon(Icons.add)),
    );
  }
}
