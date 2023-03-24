import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:task_flutter_app/components/task.dart';
import 'package:task_flutter_app/data/task_dao.dart';
import 'package:task_flutter_app/screens/form_screen.dart';

import '../components/backdrop/custom_backdrop/confirm_backdrop.dart';
import '../components/backdrop/custom_backdrop/custom_backdrop.dart';

class InitialScreen extends StatefulWidget {
  static String routeName = "/initial_screen";
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final CustomBackdrop _customBackdrop = CustomBackdrop();

  @override
  Widget build(BuildContext contextScaffold) {
    return Scaffold(
      key: _scaffoldKey,
      //estrutura pronta de layout
      appBar: AppBar(
          leading: Container(color: Colors.black26),
          actions: const [
            // IconButton(
            //     onPressed: () {
            //       setState(() {});
            //     },
            //     icon: const Icon(Icons.refresh))
          ],
          title: const Text('Tarefas')),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 70),
        child: FutureBuilder<List<Task>>(
            future: TaskDao().findAll(),
            builder: (context, snapshot) {
              List<Task>? items = snapshot.data;
              //identificando os estados da conexão
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                      child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Sem conexão')
                    ],
                  ));
                  break;
                case ConnectionState.waiting:
                  return Center(
                      child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Aguardando conexão')
                    ],
                  ));
                  break;
                case ConnectionState.active:
                  return Center(
                      child: Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('Conexão ativa')
                    ],
                  ));
                  break;
                case ConnectionState
                    .done: //requisição finalizada - retornando a listagem de Tasks do banco de dados
                  if (snapshot.hasData && items != null) {
                    if (items.isNotEmpty) {
                      return ListView.builder(
                          cacheExtent: 99999,
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Task tarefa = items[index];
                            tarefa.functionRemove = (){
                              _customBackdrop.bottomSheet(contextScaffold,
                                ConfirmBackdrop(code: tarefa.nome, confirm: (){
                                  TaskDao().delete(tarefa.nome);
                                  setState(() {
                                  items.removeAt(index);
                                  });
                                },),
                                showPan: true
                              );
                            };
                            tarefa.functionUpdate = () {
                                Navigator.push(
                                  context,
                                  MaterialWithModalsPageRoute(
                                    builder: (contextNew) => FormScreen(
                                      taskContext: context,
                                      task: tarefa
                                    ),
                                  ),
                                ).then((value) => setState(() {
                                      //passando um setState para indicar para a tela fazer um rebuild ao adicionar uma nova tarefa no banco de dados
                                      print('Recarregando a tela inicial');
                                    }));
                              };
                            return tarefa;
                          });
                  }
                   return
                   Center(
                     child: Column(
                       children: const [
                         Icon(Icons.error_outline, size: 128),
                         Text('Não há nenhuma Tarefa',
                             style: TextStyle(fontSize: 32))
                       ],
                     ),
                   );
                 }
                 return Text('Erro ao carregar Tarefas ');
                 break;
             }
             return Text('Erro desconhecido');
           }),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialWithModalsPageRoute(
                builder: (contextNew) => FormScreen(
                  taskContext: context,
                ),
              ),
            ).then((value) => setState(() {
                  //passando um setState para indicar para a tela fazer um rebuild ao adicionar uma nova tarefa no banco de dados
                  print('Recarregando a tela inicial');
                }));
          },
          child: const Icon(Icons.add)),
    );
  }
}
