import 'package:flutter/material.dart';
import 'package:project_caronae/data/ride_data.dart';
import 'package:project_caronae/pages/start_app.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RideData(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Caronaê',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: StartApp());
  }
}
