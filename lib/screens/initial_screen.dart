import 'package:flutter/material.dart';
import 'package:task_flutter_app/components/task.dart';
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
        children: const [
          Task('Aprender Flutter', 'assets/images/flutter.png', 3),
          Task('Andar de Bike', 'assets/images/bike.jpg', 2),
          Task('Meditar na praia enquanto ouve as ondas do mar',
              'assets/images/meditation.jpeg', 5),
          Task('Ler', 'assets/images/book.jpg', 4),
          Task('Jogar', 'assets/images/playgame.jpg', 0),
          SizedBox(
            height: 80,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FormScreen(),
              ),
            );
          },
          child: const Icon(Icons.add)),
    );
  }
}
