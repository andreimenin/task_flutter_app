import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:task_flutter_app/components/difficulty.dart';
import 'package:task_flutter_app/components/imageCustom.dart';
import 'package:task_flutter_app/data/task_dao.dart';

// ignore: must_be_immutable
class Task extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;
  int nivel;
  late Function? functionUpdate;
  late Function? functionRemove;

  Task(this.nome, this.foto, this.dificuldade, this.nivel, {super.key, this.functionUpdate});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  // Identificando se a imagem será asset ou tipo network se conter 'http' na url
  // bool assetOrNetwork() {
  //   if (widget.foto.contains('http')) {
  //     return false;
  //   }
  //   return true;
  // }
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.blue,
                  ),
                  child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                    ),
                    //height: 100,
                    child: IntrinsicHeight(
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
                                child: ImageCustom(image: widget.foto,)
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.nome,
                                      style: const TextStyle(
                                          fontSize: 24,
                                          //overflow: TextOverflow.ellipsis
                                          ),
                                    ),
                                    Difficulty(difficultyLevel: widget.dificuldade),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Material(
                                    type: MaterialType.transparency,
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blue, width: 1.0),
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.white,
                                      ),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(6.0),
                                        onTap: () {
                                        if(widget.functionRemove!=null){
                                          widget.functionRemove!();
                                          }
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(3.0),
                                          child: Icon(PhosphorIcons.trash, color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Material(
                                    type: MaterialType.transparency,
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blue, width: 1.0),
                                        borderRadius: BorderRadius.circular(6),
                                        color: Colors.white,
                                      ),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(6.0),
                                        onTap: () {
                                        if(widget.functionUpdate!=null){
                                          widget.functionUpdate!();
                                        }
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(3.0),
                                          child: Icon(PhosphorIcons.pencil, color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: SizedBox(
                                height: 45,
                                width: 52,
                                child: ElevatedButton(
                                    style: TextButton.styleFrom(
                                      minimumSize: Size.zero, // Set this
                                      padding: EdgeInsets.zero, // and this
                                    ),
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
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: const [
                                        Icon(PhosphorIcons.arrow_fat_up_fill, size: 20,),
                                        Text(
                                          'UP',
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ],
                                    )),
                              ),
                            ),
                          ]),
                    ),
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
            ),
            ],
          ),
        ),
      ],
    );
  }



}
