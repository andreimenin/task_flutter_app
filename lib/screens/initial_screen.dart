import 'package:flutter/material.dart';
import 'package:task_flutter_app/components/task.dart';
import 'package:task_flutter_app/data/task_dao.dart';
import 'package:task_flutter_app/screens/form_screen.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Task tarefa = items[index];
                            tarefa.functionUpdate = (){
                              setState(() {
                                items.removeAt(index);
                                });
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
              MaterialPageRoute(
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
