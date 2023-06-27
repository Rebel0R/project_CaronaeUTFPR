import 'package:flutter/material.dart';
import 'package:project_caronae/components/user_components.dart';
import 'package:project_caronae/pages/offer_ride.dart';
import 'package:project_caronae/pages/perfil.dart';
import 'package:project_caronae/pages/search_ride.dart';
import 'package:provider/provider.dart';

import '../components/ride_component.dart';
import '../components/ride_widget_component.dart';
import '../data/ride_data.dart';

class MyRides extends StatefulWidget {
  User authenticatedUser;

  MyRides({Key? key, required this.authenticatedUser}) : super(key: key);

  @override
  State<MyRides> createState() => _MyRidesState();
}

class _MyRidesState extends State<MyRides> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF4DF),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xFFFFF4DF), // define a cor do ícone
        ),
        backgroundColor: Color(0XFFFF7B00),
        title: Text(
          'Minhas Caronas',
          style: TextStyle(
            color: Color(0xFFFFF4DF),
            fontFamily: 'Roboto',
          ),
        ),
      ),
      body: Consumer<RideData>(builder: (context, rides, child) {
        return rides.list.isEmpty
            ? ListTile(
                title: Text(
                  'Você ainda não ofereceu nenhuma carona',
                  style: TextStyle(
                    color: Color(0XFFFF7B00),
                    fontFamily: 'Roboto',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: rides.list.length,
                itemBuilder: (_, index) {
                  return (rides.list[index].ride.raDriver ==
                          widget.authenticatedUser.ra)
                      ? RideWidget(
                          Ride(
                              nameDriver: rides.list[index].ride.nameDriver,
                              raDriver: rides.list[index].ride.raDriver,
                              date: rides.list[index].ride.date,
                              hour: rides.list[index].ride.hour,
                              locationStart:
                                  rides.list[index].ride.locationStart,
                              locationEnd: rides.list[index].ride.locationEnd,
                              value: rides.list[index].ride.value,
                              numberPassengers:
                                  rides.list[index].ride.numberPassengers),
                          widget.authenticatedUser.ra,
                          false)
                      : SizedBox(
                          height: 0,
                        );
                },
              );
      }),
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
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Color(0XFFFFF4DF)),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OfferRide(
                                  authenticatedUser: widget.authenticatedUser,
                                )));
                  },
                  child: Text(
                    'Caronas',
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
