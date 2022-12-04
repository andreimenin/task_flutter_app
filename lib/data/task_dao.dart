import 'package:sqflite/sqflite.dart';
import 'package:task_flutter_app/components/task.dart';
import 'package:task_flutter_app/data/database.dart';

//classe responsável por qualquer comunicação com o banco de dados
class TaskDao {
  //utilizando o static para sempre ter esses mesmos valores quando a classe ser instanciada
  static String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_difficulty INTEGER, '
      '$_image TEXT)';

  static String _tablename = 'taskTable';
  static String _name = 'name';
  static String _difficulty = 'difficulty';
  static String _image = 'image';

  //método para salvar ou atualizar uma Task (tarefa)
  save(Task tarefa) async {
    print('Iniciando o save: ');
    final Database bancoDeDados = await getDatabase();
    var itemExists = await find(tarefa.nome);
    if (itemExists.isEmpty) {
      print('a tarefa não existia.');
      return await bancoDeDados.insert(_tablename, values);
    } else {
      print('A Tarefa já existia!');
      return await bancoDeDados.update(
        _tablename,
        values,
        where: '$_name = ?',
        whereArgs: [tarefa.nome],
      );
    }
  }

  //função de read (listagem)
  Future<List<Task>> findAll() async {
    //Future utilizado para chamar requisições de carregamento de dados
    print('Acessando o findAll: ');
    final Database bancoDeDados =
        await getDatabase(); //o await significa que irá esperar fazer a requisição da função Future
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tablename);
    print('Procurando dados no banco de dados... encontrado: $result');
    return toList(result);
  }

  //função utilizada para transformar a lista de map em uma lista de Task
  List<Task> toList(List<Map<String, dynamic>> mapDeTarefas) {
    print('Convertendo to List:');
    final List<Task> tarefas = [];
    for (Map<String, dynamic> linha in mapDeTarefas) {
      final Task tarefa = Task(linha[_name], linha[_image], linha[_difficulty]);
      tarefas.add(tarefa);
    }
    print('Lista de Tarefas $tarefas');
    return tarefas;
  }

  //buscar uma task por nome
  Future<List<Task>> find(String nomeDaTarefa) async {
    print('Acessando find: ');
    final Database bancoDeDados = await getDatabase();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tablename,
      where: '$_name = ?',
      whereArgs: [nomeDaTarefa],
    );
    print('Tarefa encontrada: ${toList(result)}');
    return toList(result);
  }

  delete(String nomeDaTarefa) async {}
}
