import 'package:flutter/material.dart';
import 'package:project_caronae/components/user_components.dart';
import 'package:project_caronae/pages/my_rides.dart';
import 'package:project_caronae/pages/offer_ride.dart';
import 'package:project_caronae/pages/search_ride.dart';
import 'package:project_caronae/pages/start_app.dart';
//import 'package:project_caronae/data/users_dao_data.dart';
//import 'package:project_caronae/data/rides_dao_data.dart';
import 'dart:convert';
import 'dart:typed_data';

class MyPerfil extends StatefulWidget {
  User authenticatedUser;
  MyPerfil({Key? key, required this.authenticatedUser}) : super(key: key);

  @override
  State<MyPerfil> createState() => _MyPerfilState();
}

class _MyPerfilState extends State<MyPerfil> {
  @override
  Widget build(BuildContext context) {
    String profilePhoto = widget.authenticatedUser.profilePhoto;
    bool hasProfilePhoto = profilePhoto.isNotEmpty;
    Uint8List? photoBytes = hasProfilePhoto ? base64Decode(profilePhoto) : null;

    return Scaffold(
      body: Container(
        width: 412,
        height: 707,
        color: Color(0xFFFFF4DF),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 38),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            widget.authenticatedUser.fullname,
                            maxLines: 2,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color(0XFFFF7B00)),
                          ),
                        ),
                        Text(
                          'Aluno da UTFPR',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 20,
                              fontWeight: FontWeight.w200,
                              color: Color(0XFFFF7B00)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 57, 57, 57),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: hasProfilePhoto
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.memory(
                              photoBytes!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Icon(
                            Icons.image_sharp,
                            size: 50,
                            color: Colors.white54,
                          ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Color(0XFFFF7B00),
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, right: 8, left: 8, bottom: 8),
                  child: Text(
                    'Seus Dados',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 23,
                        color: Color(0XFFFF7B00),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      width: 335,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Color(0XFFFF7B00), width: 2),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        widget.authenticatedUser.email,
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          color: Color(0XFFFF7B00),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 8, right: 8, bottom: 30),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      width: 335,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Color(0XFFFF7B00), width: 2),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'RA: ${widget.authenticatedUser.ra}',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14,
                          color: Color(0XFFFF7B00),
                        ),
                      )),
                ),
              ],
            ),
            Container(
              width: 122,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  //await UserDao().deleteAllUsers();
                  //await RideDao().deleteAllRides();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => StartApp()));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Logout realizado'),
                    ),
                  );
                },
                child: Text(
                  'Sair',
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
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFFF7B00))),
              ),
            ),
          ],
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
                  onPressed: () {
                    print('Clicou!');
                    Navigator.pushReplacement(
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
                  onPressed: null,
                  child: Text(
                    'Perfil',
                    style: TextStyle(
                        decorationThickness: 2,
                        decoration: TextDecoration.underline,
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
