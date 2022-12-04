//classe responsável por qualquer comunicação com o banco de dados
import 'package:sqflite/sqflite.dart';
import 'package:task_flutter_app/components/task.dart';
import 'package:task_flutter_app/data/database.dart';

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

  save(Task tarefa) async {}
  //função de read (listagem)
  Future<List<Task>> findAll() async {
    //Future utilizado para chamar requisições de carregamento de dados
    print('Acessando o findAll: ');
    final Database bancoDeDados = await getDatabase(); //o await significa que irá esperar fazer a requisição da função Future
    final List<Map<String, dynamic>> result = await bancoDeDados.query(_tablename);
    print('Procurando dados no banco de dados... encontrado: $result');
    return toList();
  }
  Future<List<Task>> find(String nomeDaTarefa) async {}
  delete(String nomeDaTarefa) async {}
}
