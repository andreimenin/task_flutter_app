import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool opacidade = true;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
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
              setState((){
                {
                  opacidade = !opacidade;
                }
              });
            },
            child: Icon(Icons.remove_red_eye)),
      ),
    );
  }
}

class Task extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;

  const Task(this.nome, this.foto, this.dificuldade, {Key? key})
      : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int nivel = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Stack(
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.blue,
                ),
                height: 140),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  height: 100,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.black26,
                          ),
                          width: 72,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              widget.foto,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 200,
                                child: Text(
                                  widget.nome,
                                  style: TextStyle(
                                      fontSize: 24,
                                      overflow: TextOverflow.ellipsis),
                                )),
                            Row(
                              children: [
                                Icon(Icons.star,
                                    size: 15,
                                    color: (widget.dificuldade >= 1)
                                        ? Colors.blue
                                        : Colors.blue[100]),
                                Icon(Icons.star,
                                    size: 15,
                                    color: (widget.dificuldade >= 2)
                                        ? Colors.blue
                                        : Colors.blue[100]),
                                Icon(Icons.star,
                                    size: 15,
                                    color: (widget.dificuldade >= 3)
                                        ? Colors.blue
                                        : Colors.blue[100]),
                                Icon(Icons.star,
                                    size: 15,
                                    color: (widget.dificuldade >= 4)
                                        ? Colors.blue
                                        : Colors.blue[100]),
                                Icon(Icons.star,
                                    size: 15,
                                    color: (widget.dificuldade >= 5)
                                        ? Colors.blue
                                        : Colors.blue[100]),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          height: 52,
                          width: 52,
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  //observando o valor da variavel nivel para re-renderizar a tela
                                  nivel++;
                                });
                                print(nivel);
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(Icons.arrow_drop_up),
                                  Text(
                                    'UP',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              )),
                        )
                      ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        child: LinearProgressIndicator(
                            color: Colors.white,
                            value: (widget.dificuldade > 0)
                                ? (nivel / widget.dificuldade)
                                : 1),
                        width: 200,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        'Nível: $nivel',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
