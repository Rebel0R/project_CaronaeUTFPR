import 'package:project_caronae/components/ride_component.dart';
import 'package:project_caronae/data/database.dart';
import 'package:sqflite/sqflite.dart';

class RideDao {
  static const String tableSql = 'CREATE TABLE $_tablename('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$_nameDriver TEXT, '
      '$_raDriver TEXT, '
      '$_date TEXT, '
      '$_hour TEXT, '
      '$_locationStart TEXT, '
      '$_locationEnd TEXT, '
      '$_value REAL, '
      '$_namePassengers TEXT, '
      '$_numberPassengers INT)';

  static const String _tablename = 'RideTable';
  static const String _nameDriver = 'nameDriver';
  static const String _raDriver = 'raDriver';
  static const String _date = 'date';
  static const String _hour = 'hour';
  static const String _locationStart = 'locationStart';
  static const String _locationEnd = 'locationEnd';
  static const String _value = 'value';
  static const String _namePassengers = 'namePassengers';
  static const String _numberPassengers = 'numberPassengers';

  saveRide(Ride ride) async {
    print('\tCADASTRO DE CORRIDA');
    final Database bancoDeDados = await getDatabaseRide();
    var itemExists = await findRide(ride.nameDriver, ride.date, ride.hour,
        ride.locationStart, ride.locationEnd);
    Map<String, dynamic> rideMap = converteMap(ride);
    if (itemExists.isEmpty) {
      print('Registrando corrida no banco');
      try {
        print('Corrida cadastrado com sucesso!');
        return await bancoDeDados.insert(_tablename, rideMap);
      } catch (e) {
        print('Erro ao cadastrar corrida: $e');
      }
    } else {
      print('Corrida já existente no banco!');
    }
  }

  Future<int> updateRidePassengers(int rideId, String newRAPassenger) async {
    print('\tATUALIZAÇÃO DE CARONA');
    final Database bancoDeDados = await getDatabaseRide();
    try {
      print('Atualizando campo _namePassengers da carona no banco');

      // Recupera a string existente do campo _namePassengers
      String existingNamePassengers = await getExistingRaPassengers(rideId);
      if (existingNamePassengers.isEmpty) {
        return await bancoDeDados.update(
          _tablename,
          {_namePassengers: '$newRAPassenger, '},
          where: 'id = ?',
          whereArgs: [rideId],
        );
      } else {
        // Concatena o novo valor à string existente
        String updatedNamePassengers =
            '$existingNamePassengers, $newRAPassenger';
        return await bancoDeDados.update(
          _tablename,
          {_namePassengers: updatedNamePassengers},
          where: 'id = ?',
          whereArgs: [rideId],
        );
      }
      // Atualiza o campo _namePassengers com a nova string concatenada
    } catch (e) {
      print('Erro ao atualizar campo _namePassengers da carona: $e');
      return 0;
    }
  }

  Future<String> getExistingRaPassengers(int rideId) async {
    final Database bancoDeDados = await getDatabaseRide();
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tablename,
      columns: [_namePassengers],
      where: 'id = ?',
      whereArgs: [rideId],
    );
    if (result.isNotEmpty) {
      return result[0][_namePassengers];
    } else {
      return '';
    }
  }

  Future<List<Ride>> findRide(
      String name, DateTime date, String hour, String start, String end) async {
    print('\tBUSCANDO CORRIDA');
    String dateConvert = date.toString();
    final Database bancoDeDados = await getDatabaseRide();
    //print('Procurando corrida com o ra: ${registerStudent}');
    final List<Map<String, dynamic>> result = await bancoDeDados.query(
      _tablename,
      where:
          '$_nameDriver = ? AND $_date = ? AND $_hour = ? AND $_locationStart = ? AND $_locationEnd = ?',
      whereArgs: [name, dateConvert, hour, start, end],
    );
    print('BD- Corrida encontrada: ${converteList(result)}');

    return converteList(result);
  }

  Map<String, dynamic> converteMap(Ride corrida) {
    //print('Convertendo para o tipo Map: ');
    final Map<String, dynamic> mapaRide = Map();
    String dateConvert = corrida.date.toString();
    mapaRide[_date] = dateConvert;
    mapaRide[_hour] = corrida.hour;
    mapaRide[_locationStart] = corrida.locationStart;
    mapaRide[_locationEnd] = corrida.locationEnd;
    mapaRide[_nameDriver] = corrida.nameDriver;
    mapaRide[_raDriver] = corrida.raDriver;
    mapaRide[_numberPassengers] = corrida.numberPassengers;
    mapaRide[_value] = corrida.value;
    print('BD -Mapa de Corridas: $mapaRide');
    return mapaRide;
  }

  List<Ride> converteList(List<Map<String, dynamic>> mapaRides) {
    //print('Convertendo to List:');
    final List<Ride> corridas = [];

    for (Map<String, dynamic> linha in mapaRides) {
      DateTime dateConvert = DateTime.parse(linha[_date]);
      final Ride corrida = Ride(
          nameDriver: linha[_nameDriver],
          raDriver: linha[_raDriver],
          date: dateConvert,
          hour: linha[_hour],
          locationStart: linha[_locationStart],
          locationEnd: linha[_locationEnd],
          value: linha[_value],
          numberPassengers: linha[_numberPassengers]);
      corrida.id = linha['id'];
      corridas.add(corrida);
    }
    print('BD- Lista de corridas: ${corridas.toString()}');
    return corridas;
  }

  Future<List<Ride>?> listarTodasCorridas() async {
    //print('Acessando a função listaTodosUsers: ');
    final Database bancoDeDados = await getDatabaseRide();
    final List<Map<String, dynamic>> result =
        await bancoDeDados.query(_tablename);
    if (result.isNotEmpty) {
      print('BD- Dados encontrados: $result');
      return converteList(result);
    } else {
      return null;
    }
  }
}
