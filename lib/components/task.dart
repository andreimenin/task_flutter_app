import 'package:flutter/material.dart';
import 'package:task_flutter_app/components/backdrop/custom_backdrop/confirm_backdrop.dart';
import 'package:task_flutter_app/components/backdrop/custom_backdrop/custom_backdrop.dart';
import 'package:task_flutter_app/components/difficulty.dart';
import 'package:task_flutter_app/data/task_dao.dart';

class Task extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;
  int nivel;
  late Function? functionUpdate;

  Task(this.nome, this.foto, this.dificuldade, this.nivel, {this.functionUpdate});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  CustomBackdrop _customBackdrop = CustomBackdrop();
  // Identificando se a imagem será asset ou tipo network se conter 'http' na url
  bool assetOrNetwork() {
    if (widget.foto.contains('http')) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                          child: assetOrNetwork()
                              ? Image.asset(
                                  'assets/images/nophoto.png',
                                  fit: BoxFit.fitWidth,
                                )
                              : Image.network(
                                  widget.foto,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 200,
                              child: Text(
                                widget.nome,
                                style: const TextStyle(
                                    fontSize: 24,
                                    overflow: TextOverflow.ellipsis),
                              )),
                          Difficulty(difficultyLevel: widget.dificuldade),
                        ],
                      ),
                      SizedBox(
                        height: 52,
                        width: 52,
                        child: ElevatedButton(
                            onLongPress: () {
                              _customBackdrop.bottomSheet(context,
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ConfirmBackdrop(code: widget.nome, idAppointment: widget.dificuldade, confirm: (){
                                      TaskDao().delete(widget.nome);
                                      widget.functionUpdate!();
                                    },),
                                  ],
                                ),
                              );
                            },
                            onPressed: () async {
                                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                                await TaskDao().update(Task(widget.nome,
                                    widget.foto,
                                    widget.dificuldade,
                                    widget.nivel+1)
                                );
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Nível atualizado'),
                                  ),
                                );
                                //observando o valor da variavel nivel para re-renderizar a tela
                                setState(() {
                                  widget.nivel++;
                                });
                              // print(nivel);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
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
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                          color: Colors.white,
                          value: (widget.dificuldade > 0)
                              ? (widget.nivel / widget.dificuldade)
                              : 1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Nível: ${widget.nivel}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
