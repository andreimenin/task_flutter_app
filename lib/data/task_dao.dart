//classe responsável por qualquer comunicação com o banco de dados
import 'package:task_flutter_app/components/task.dart';

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
  //Future utilizado para requisições de carregamento
  Future<List<Task>> findAll() async {}
  Future<List<Task>> find(String nomeDaTarefa) async {}
  delete(String nomeDaTarefa) async {}
}
