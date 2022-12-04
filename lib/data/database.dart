import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//async acontece enquanto outras funcionalidades acontecem ao mesmo tempo
Future<Database> getDatabase() async {
  //buscando pelo caminho perfeito do dispositivo para buscar arquivos
  //task.db é o arquivo de banco de dados que será criado
  final String path = join(await getDatabasesPath(), 'task.db'); //await -> esperando o getDatabasesPath() ser encontrado
  return openDatabase(path, onCreate: (db, version) {
    db.execute(tabela)
  }, version: 1,);
}