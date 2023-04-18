import 'package:flutter/material.dart';
import 'package:project_caronae/components/user.dart';
import 'package:project_caronae/pages/offer_ride.dart';
import 'package:project_caronae/pages/perfil.dart';
import 'package:project_caronae/pages/search_ride.dart';

class MyRides extends StatefulWidget {
  User authenticatedUser;
  List<User> usersData;
  MyRides({Key? key, required this.authenticatedUser, required this.usersData})
      : super(key: key);

  @override
  State<MyRides> createState() => _MyRidesState();
}

class _MyRidesState extends State<MyRides> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 412,
        height: 707,
        color: Color(0xFFFFF4DF),
        child: Padding(
          padding: const EdgeInsets.only(top: 25, bottom: 8),
          child: Text(
            'Suas Caronas',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 28,
              color: Color(0xFFFF8D21),
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
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
                                usersData: widget.usersData)));
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
                                usersData: widget.usersData)));
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
                                usersData: widget.usersData)));
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
