//import 'package:nosso_primeiro_projeto/data/task_dao.dart';
import 'package:project_caronae/data/users_dao_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabaseUser() async {
  final String path = join(await getDatabasesPath(), 'user.db');
  print('Caminho do banco de dados: $path');
  final Database database = await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) {
      db.execute(UserDao.tableSql);
    },
  );
  // Verificar se a tabela já existe no banco de dados
  final List<Map<String, dynamic>> tables = await database
      .query('sqlite_master', where: 'name = ?', whereArgs: ['userTable']);

  if (tables.isEmpty) {
    print("A tabela não existe");
    // A tabela não existe, criar a tabela
    await database.execute(UserDao.tableSql);
  }
  print('A tabela já existente...');

  return database;
}
