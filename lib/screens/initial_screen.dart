import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/components/task.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacidade = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //estrutura pronta de layout
      appBar: AppBar(
          leading: Container(color: Colors.black26),
          title: const Text('Tarefas')),
      body: AnimatedOpacity(
        opacity: opacidade ? 1 : 0,
        duration: const Duration(milliseconds: 800),
        child: ListView(
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
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              {
                opacidade = !opacidade;
              }
            });
          },
          child: const Icon(Icons.remove_red_eye)),
    );
  }
}
