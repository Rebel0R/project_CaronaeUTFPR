import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:project_caronae/components/ride_components.dart';

class RideData extends ChangeNotifier {
  List<Ride> rideLists = [
    Ride(
      DateTime(2023, 4, 14),
      '13h50',
      'UEPG Central',
      'UTFPR',
      'Naju do DCE',
      4,
      2,
    ),
    Ride(
      DateTime(2023, 4, 14),
      '15h30',
      'UTFPR',
      'UEPG Central',
      'Naju do DCE',
      3,
      2,
    ),
    Ride(
      DateTime(2023, 4, 11),
      '18h00',
      'UEPG Central',
      'UTFPR',
      'Ricardo Rebelo Junior',
      4,
      2,
    ),
  ];

  UnmodifiableListView<Ride> get list => UnmodifiableListView(rideLists);

  saveRide(Ride newRides) {
    rideLists.add(newRides);
    notifyListeners();
  }
}
