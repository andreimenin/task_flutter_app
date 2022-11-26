import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/task.dart';

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
          leading: Container(color: Colors.black26), title: Text('Tarefas')),
      body: AnimatedOpacity(
        opacity: opacidade ? 1 : 0,
        duration: Duration(milliseconds: 800),
        child: ListView(
          children: [
            Task(
                'Aprender Flutter',
                'https://pbs.twimg.com/media/Eu7m692XIAEvxxP?format=png&name=large',
                3),
            Task(
                'Andar de Bike',
                'https://thumbs.dreamstime.com/b/woman-mountain-bike-riding-ridge-carpathian-mountains-40195258.jpg',
                2),
            Task(
                'Meditar na praia enquanto ouve as ondas do mar',
                'https://manhattanmentalhealthcounseling.com/wp-content/uploads/2019/06/Top-5-Scientific-Findings-on-MeditationMindfulness-881x710.jpeg',
                5),
            Task('Ler',
                'https://thumbs.dreamstime.com/b/book-to-read-142078.jpg', 4),
            Task(
                'Jogar',
                'https://thumbs.dreamstime.com/z/playing-video-game-close-up-child-hands-th-late-night-54233429.jpg',
                0),
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
          child: Icon(Icons.remove_red_eye)),
    );
  }
}
