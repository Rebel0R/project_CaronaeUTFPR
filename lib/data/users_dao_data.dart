import 'package:project_caronae/components/user_components.dart';
import 'package:project_caronae/data/database.dart';
import 'package:sqflite/sqflite.dart';

class UserDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      '$_name TEXT, '
      '$_email TEXT, '
      '$_registerStudent TEXT, '
      '$_password TEXT,'
      '$_profilePhoto TEXT)';

  static const String _tablename = 'usersTable';
  static const String _name = 'name';
  static const String _email = 'email';
  static const String _registerStudent = 'ra';
  static const String _password = 'password';
  static const String _profilePhoto = 'profilePhoto';

  saveUser(User usuario) async {
    print('\tCADASTRO DE USUARIO');
    final Database bancoDeDados = await getDatabaseUser();
    var itemExists = await findUser(usuario.ra);
    Map<String, dynamic> userMap = converteMap(usuario);
    if (itemExists.isEmpty) {
      print('Registrando usuário no banco');
      try {
        print('Usuário cadastrado com sucesso!');
        return await bancoDeDados.insert(_tablename, userMap);
      } catch (e) {
        print('Erro ao cadastrar o usuário o usuário: $e');
      }
    } else {
      print('Usuário existente no banco!');
    }
  }

  Future<User?> updateUserPassword(
      String emailStudent, String oldPassword, String newPassword) async {
    print('\tATUALIZAR SENHA');
    final Database database = await getDatabaseUser();

    final List<Map<String, dynamic>> result = await database.query(
      _tablename,
      where: '$_email = ? AND $_password = ?',
      whereArgs: [emailStudent, oldPassword],
    );

    if (result.isNotEmpty) {
      final user = converteUser(result.first);
      user.password = newPassword;
      Map<String, dynamic> userMap = converteMap(user);
      await database.update(
        _tablename,
        userMap,
        where: '$_email = ?',
        whereArgs: [emailStudent],
      );
      print('Senha do usuário atualizada com sucesso!');
      return user;
    } else {
      print('Usuário não encontrado. Não foi possível atualizar a senha.');
      return null;
    }
  }

  Map<String, dynamic> converteMap(User usuario) {
    final Map<String, dynamic> mapaUsers = Map();
    mapaUsers[_name] = usuario.fullname;
    mapaUsers[_email] = usuario.email;
    mapaUsers[_registerStudent] = usuario.ra;
    mapaUsers[_password] = usuario.password;
    mapaUsers[_profilePhoto] = usuario.profilePhoto;
    print('Mapa de Usuário: $mapaUsers'); // Add profilePhoto to the map
    return mapaUsers;
  }

  Future<List<User>> listaTodosUsers() async {
    //print('Acessando a função listaTodosUsers: ');
    final Database bancoDeDados = await getDatabaseUser();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tablename);
    print(
        'Procurando usuários no banco de dados... \nDado encontrado: $result');
    return converteList(result);
  }

  List<User> converteList(List<Map<String, dynamic>> mapaUsers) {
    //print('Convertendo to List:');
    final List<User> usuarios = [];
    for (Map<String, dynamic> linha in mapaUsers) {
      final User usuario = User(
          fullname: linha[_name],
          email: linha[_email],
          ra: linha[_registerStudent],
          password: linha[_password],
          profilePhoto: linha[_profilePhoto]);
      usuarios.add(usuario);
    }
    print('Lista de Usuarios: ${usuarios.toString()}');
    return usuarios;
  }

  Future<List<User>> findUser(String registerStudent) async {
    print('\tBUSCANDO USUÁRIO RA: ${registerStudent}');
    final Database bancoDeDados = await getDatabaseUser();
    //print('Procurando usuario com o ra: ${registerStudent}');
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
        _tablename,
        where: '$_registerStudent = ?',
        whereArgs: [registerStudent]);
    print('Usuário encontrado: ${converteList(result)}');

    return converteList(result);
  }

  User converteUser(Map<String, dynamic> mapaUser) {
    return User(
        fullname: mapaUser[_name],
        email: mapaUser[_email],
        ra: mapaUser[_registerStudent],
        password: mapaUser[_password],
        profilePhoto: mapaUser[_profilePhoto]);
  }

  Future<User?> encontrarUserBanco(String ra, String password) async {
    print('\tBUSCANDO USUÁRIO');
    final Database database = await getDatabaseUser();
    final List<Map<String, dynamic>> result = await database.query(
      _tablename,
      where: '$_registerStudent = ? AND $_password = ?',
      whereArgs: [ra, password],
      limit: 1,
    );

    if (result.isNotEmpty) {
      print('Usuário encontrado!');
      return converteUser(result.first);
    } else {
      return null; // Credenciais inválidas
    }
  }

  delete(String registerStudent) async {
    print('Deletando usuario: $registerStudent');
    final Database bancoDeDados = await getDatabaseUser();
    return await bancoDeDados.delete(
      _tablename,
      where: '$_name = ?',
      whereArgs: [registerStudent],
    );
  }

  //limpando a lista
  Future<void> deleteAllUsers() async {
    print('Excluindo todos os usuários');
    final Database bancoDeDados = await getDatabaseUser();
    await bancoDeDados.delete(_tablename);
    print('Todos os usuários foram excluídos');
  }
}
