import 'package:flutter/material.dart';
import 'package:project_caronae/components/user_components.dart';
import 'package:project_caronae/pages/feed.dart';
import 'package:project_caronae/pages/my_rides.dart';
import 'package:project_caronae/pages/offer_ride.dart';
import 'package:project_caronae/pages/perfil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchRide extends StatefulWidget {
  User authenticatedUser;

  SearchRide({
    Key? key,
    required this.authenticatedUser,
  }) : super(key: key);

  @override
  State<SearchRide> createState() => _SearchRideState();
}

class _SearchRideState extends State<SearchRide> {
  final _formKey = GlobalKey<FormState>();
  List locationsSart = [
    'Praça Barão Rio Branco',
    'UEPG Central',
    'Posto Petrobras (Jd Carvalho)',
    'Eskimó Sorvetes',
    'Farmácia Flaming (Jd Carvalho)',
    'Farmácia Droga Raia',
    'Supermercado Condor (Jd Carvalho)',
    'Supermercado Max (Jd Carvalho)',
    'UTFPR'
  ];
  final dropdownValueStart = ValueNotifier<String>('');

  List locationsEnd = [
    'UTFPR',
    'Supermercado Max (Jd Carvalho)',
    'Supermercado Condor (Jd Carvalho)',
    'Supermercado Tozzeto',
    'Condomínio Raul',
    'KNN Idiomas',
    'Posto Petrobras (Jd Carvalho)',
    'UEPG Central',
    'Praça Barão Rio Branco',
  ];
  final dropdownValueEnd = ValueNotifier<String>('');

  //final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showWelcomeDialog(context);
    });
  }

  Future<Map<String, dynamic>> fetchTemperature() async {
    final response = await http.get(Uri.parse(
        'https://api.weatherbit.io/v2.0/current?lat=-25.0916&lon=-50.1615&key=d0d529824ea34616b343a1fb74741414&include=minutely'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final city = data['data'][0]['city_name'].toString();
      final temperature = data['data'][0]['temp'].toString();
      final precip = data['data'][0]['precip'].toString();
      //print(data);
      return {'temperature': temperature, 'precip': precip, 'city': city};
    } else {
      throw Exception('${response.statusCode}');
    }
  }

  void showWelcomeDialog(BuildContext context) async {
    final BuildContext dialogContext = context;

    try {
      final Map<String, dynamic> climate = await fetchTemperature();
      String message;
      String temperatureString = climate['temperature'];
      int precip = int.parse(climate['precip']);
      double temperatureValue = double.tryParse(temperatureString) ?? 0.0;

      if (temperatureValue != null) {
        if (precip == 0) {
          if (temperatureValue > 25) {
            message = 'Beba muita água, Caroner';
          } else if (temperatureValue < 15) {
            message = 'Não esqueça de se agasalhar, Caroner';
          } else {
            message = 'Boa carona, Caroner!';
          }
        } else {
          message = 'Não esqueça do guarda-chuva';
        }
      } else {
        message = '';
      }

      showDialog(
        context: dialogContext,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: SizedBox(
                height: 160,
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: temperatureValue > 20
                            ? Image.asset('images/icon-Summer.png')
                            : Image.asset('images/icon-winter.png'),
                      ),
                    ),
                    Text(
                      'Bem-vindo, ${widget.authenticatedUser.fullname}',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Color(0XFFF26700),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Temperatura em ${climate['city']}: ${climate['temperature']}°C',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Color(0XFFF26700),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      message,
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Color(0XFFF26700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // Fechar o diálogo
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Erro ao buscar a temperatura: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    //fetchWeatherForecast();
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: 412,
        height: 707,
        color: Color(0xFFFFF4DF),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  width: 280,
                  child: Image.asset('images/logoOrange.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 25, right: 20, left: 20, bottom: 8),
                  child: ValueListenableBuilder(
                    valueListenable: dropdownValueStart,
                    builder: (BuildContext context, String value, _) {
                      return SizedBox(
                        width: 330,
                        height: 60,
                        child: DropdownButtonFormField(
                          validator: (value) {
                            if (value == null) {
                              return ('Escolhe uma opção válida');
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              label: Text('Partida'),
                              border: OutlineInputBorder(),
                              labelStyle: TextStyle(
                                  color: Color(0XFFF26700),
                                  fontFamily: 'Roboto'),
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0XffFF8D21)))),
                          isExpanded: true,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Color(0XFFF26700),
                          ),
                          hint: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Color(0XFFF26700),
                              ),
                              Text(
                                'De (localização ou UTFPR):',
                                style: TextStyle(color: Color(0XFFF26700)),
                              )
                            ],
                          ),
                          value: (value.isEmpty) ? null : value,
                          onChanged: (choice) =>
                              dropdownValueStart.value = choice.toString(),
                          items: locationsSart
                              .map(
                                (opcao) => DropdownMenuItem(
                                  child: Text(opcao),
                                  value: opcao,
                                ),
                              )
                              .toList(),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, right: 20, left: 20, bottom: 16),
                  child: ValueListenableBuilder(
                    valueListenable: dropdownValueEnd,
                    builder: (BuildContext context, String value, _) {
                      return SizedBox(
                        width: 330,
                        height: 60,
                        child: DropdownButtonFormField(
                          validator: (value) {
                            if (value == null) {
                              return ('Escolha uma opção válida');
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              label: Text('Destino'),
                              border: OutlineInputBorder(),
                              labelStyle: TextStyle(
                                  color: Color(0XFFF26700),
                                  fontFamily: 'Roboto'),
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0XffFF8D21)))),
                          isExpanded: true,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Color(0XFFF26700),
                          ),
                          hint: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Color(0XFFF26700),
                              ),
                              Text(
                                'Para (localização ou UTFPR):',
                                style: TextStyle(color: Color(0XFFF26700)),
                              )
                            ],
                          ),
                          value: (value.isEmpty) ? null : value,
                          onChanged: (choice) =>
                              dropdownValueEnd.value = choice.toString(),
                          items: locationsEnd
                              .map(
                                (opcao) => DropdownMenuItem(
                                  child: Text(opcao),
                                  value: opcao,
                                ),
                              )
                              .toList(),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  width: 330,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // print('De: ' +
                        //     dropdownValueStart.value +
                        //     ' -> Para: ' +
                        //     dropdownValueEnd.value);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Feed(
                                    start: dropdownValueStart.value,
                                    end: dropdownValueEnd.value,
                                    authenticatedUser:
                                        widget.authenticatedUser)));
                      }
                    },
                    child: Text(
                      'Procurar',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 244, 223),
                          fontFamily: 'Roboto',
                          fontSize: 22),
                    ),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFFFF7B00))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0XFFFF7B00),
        child: Padding(
          padding: const EdgeInsets.only(left: 41, right: 41),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: null,
                  child: Text(
                    'Procurar',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        decorationThickness: 2,
                        decoration: TextDecoration.underline,
                        color: Color(0XFFFFF4DF)),
                  )),
              TextButton(
                  onPressed: () {
                    print('Clicou!');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (newContext) => OfferRide(
                                  authenticatedUser: widget.authenticatedUser,
                                )));
                  },
                  child: Text(
                    'Oferecer',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Color(0XFFFFF4DF)),
                  )),
              TextButton(
                  onPressed: () {
                    print('Clicou!');
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyRides(
                                  authenticatedUser: widget.authenticatedUser,
                                )));
                  },
                  child: Text(
                    'Caronas',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Color(0XFFFFF4DF)),
                  )),
              TextButton(
                  onPressed: () {
                    print('Clicou!');
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyPerfil(
                                  authenticatedUser: widget.authenticatedUser,
                                )));
                  },
                  child: Text(
                    'Perfil',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Color(0XFFFFF4DF)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
