import 'package:flutter/material.dart';
import 'package:project_caronae/components/ride_components.dart';
import 'package:project_caronae/components/user_components.dart';
import 'package:project_caronae/data/ride_data.dart';
import 'package:project_caronae/pages/my_rides.dart';
import 'package:project_caronae/pages/perfil.dart';
import 'package:project_caronae/pages/search_ride.dart';
import 'package:provider/provider.dart';

class OfferRide extends StatefulWidget {
  User authenticatedUser;
  OfferRide({
    Key? key,
    required this.authenticatedUser,
  }) : super(key: key);

  @override
  State<OfferRide> createState() => _OfferRideState();
}

class _OfferRideState extends State<OfferRide> {
  late RideData allRides;
  TextEditingController priceController = TextEditingController();
  TextEditingController passengerController = TextEditingController();
  TextEditingController timeController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    allRides = context.watch<RideData>();
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
                      top: 8, right: 20, left: 20, bottom: 8),
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
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, right: 20, left: 20, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 80,
                        height: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty || double.parse(value) < 0) {
                              return 'Valor inválido ou inexistente!';
                            }
                            return null;
                          },
                          controller: priceController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              errorMaxLines: 2,
                              border: OutlineInputBorder(),
                              labelText: 'Valor:',
                              labelStyle: TextStyle(
                                  color: Color(0XFFF26700),
                                  fontFamily: 'Roboto'),
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0XFFF26700)))),
                        ),
                      ),
                      SizedBox(width: 16), // Espaçamento entre os campos
                      SizedBox(
                        width: 80,
                        height: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty ||
                                int.parse(value) < 0 ||
                                int.parse(value) > 4) {
                              return 'Número de passageiros inválido ou inexistente!';
                            }
                            return null;
                          },
                          controller: passengerController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              errorMaxLines: 2,
                              border: OutlineInputBorder(),
                              labelText: 'Vagas:',
                              labelStyle: TextStyle(
                                  color: Color(0XFFF26700),
                                  fontFamily: 'Roboto'),
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0XFFF26700)))),
                        ),
                      ),
                      SizedBox(width: 16),
                      SizedBox(
                        width: 80,
                        height: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty || value.length > 5) {
                              return 'Hora inválida ou inexistente!';
                            }
                            if (!value.contains(':')) {
                              return 'Formato inválido, tente HH:mm';
                            }
                            return null;
                          },
                          controller: timeController,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              errorMaxLines: 2,
                              border: OutlineInputBorder(),
                              labelText: 'Hora:',
                              labelStyle: TextStyle(
                                  color: Color(0XFFF26700),
                                  fontFamily: 'Roboto'),
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0XFFF26700)))),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 330,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        DateTime now = DateTime.now();
                        allRides.saveRide(Ride(
                          now,
                          timeController.text,
                          dropdownValueStart.value,
                          dropdownValueEnd.value,
                          widget.authenticatedUser.fullname,
                          int.parse(passengerController.text),
                          double.parse(priceController.text),
                        ));

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Corrida oferecida com sucesso!'),
                          ),
                        );
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchRide(
                                      authenticatedUser:
                                          widget.authenticatedUser,
                                    )));
                      }
                    },
                    child: Text(
                      'Oferecer',
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
                  onPressed: () {
                    print('Clicou!');
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchRide(
                                  authenticatedUser: widget.authenticatedUser,
                                )));
                  },
                  child: Text(
                    'Procurar',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Color(0XFFFFF4DF)),
                  )),
              TextButton(
                  onPressed: null,
                  child: Text(
                    'Oferecer',
                    style: TextStyle(
                        decorationThickness: 2,
                        decoration: TextDecoration.underline,
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
    ;
  }
}
