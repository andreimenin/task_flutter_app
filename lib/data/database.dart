import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//async acontece enquanto outras funcionalidades acontecem ao mesmo tempo
Future<Database> getDatabase() async {
  //buscando pelo caminho perfeito do dispositivo para buscar arquivos
  //task.db é o arquivo de banco de dados que será criado
  final String path = join(await getDatabasesPath(), 'task.db'); //await -> esperando o getDatabasesPath() ser encontrado
  return openDatabase(path, onCreate: (db, version) {
    db.execute(tableSql);
  }, version: 1,);
}
const String tableSql = 'CREATE TABLE $_tablename('
    '$_name TEXT, '
    '$_difficulty INTEGER, '
    '$_image TEXT)';

const String _tablename = 'taskTable';
const String _name = 'name';
const String _difficulty = 'difficulty';
const String _image = 'image';
