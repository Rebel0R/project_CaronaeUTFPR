import 'package:project_caronae/data/rides_dao_data.dart';
import 'package:project_caronae/data/users_dao_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Future<Database> getDatabaseUser() async {
//   final String path = join(await getDatabasesPath(), 'user1.db');
//   print('Caminho do banco de dados: $path');
//   final Database database = await openDatabase(
//     path,
//     version: 1,
//     onCreate: (db, version) {
//       db.execute(UserDao.tableSql);
//     },
//   );
//   // Verificar se a tabela já existe no banco de dados
//   final List<Map<String, dynamic>> tables = await database
//       .query('sqlite_master', where: 'name = ?', whereArgs: ['usersTable']);

//   if (tables.isEmpty) {
//     print("A tabela não existe");
//     // A tabela não existe, criar a tabela
//     await database.execute(UserDao.tableSql);
//   }
//   print('A tabela já existente...');

//   return database;
// }

Future<Database> getDatabaseUser() async {
  final String path = join(await getDatabasesPath(), 'user1.db');
  print('Caminho do banco de dados: $path');
  final Database database = await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) {},
  );

  // Verificar se a tabela já existe no banco de dados
  final List<Map<String, dynamic>> tables = await database
      .query('sqlite_master', where: 'name = ?', whereArgs: ['usersTable']);

  if (tables.isEmpty) {
    print("A tabela não existe");
    // A tabela não existe, criar a tabela
    await database.execute(UserDao.tableSql);
  }
  print('A tabela já existente...');

  return database;
}

Future<Database> getDatabaseRide() async {
  final String path = join(await getDatabasesPath(), 'ride.db');
  print('Caminho do banco de dados: $path');
  final Database database = await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) {
      db.execute(RideDao.tableSql);
    },
  );
  return database;
}
// Future<Database> getDatabaseRide() async {
//   final String path = join(await getDatabasesPath(), 'ride.db');
//   print('Caminho do banco de dados: $path');
//   final Database database = await openDatabase(
//     path,
//     version: 1,
//     onCreate: (db, version) {
//       db.execute(RideDao.tableSql);
//     },
//   );
//   // Verificar se a tabela já existe no banco de dados
//   final List<Map<String, dynamic>> tables = await database
//       .query('sqlite_master', where: 'name = ?', whereArgs: ['rideTable']);

//   if (tables.isEmpty) {
//     print("A tabela não existe");
//     // A tabela não existe, criar a tabela
//     await database.execute(RideDao.tableSql);
//   }
//   print('A tabela já existente...');

//   return database;
// }
