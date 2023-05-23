import 'dart:collection';
import 'package:project_caronae/data/rides_dao_data.dart';
import 'package:flutter/material.dart';
import 'package:project_caronae/components/ride_component.dart';
import 'package:project_caronae/components/ride_widget_component.dart';
import 'package:project_caronae/services/session_services.dart';
import '../components/user_components.dart';

class RideData extends ChangeNotifier {
  List<Ride>? rideLists;
  List<RideWidget> rideWidgetList = [];

  RideData() {
    initializeRideLists();
  }

  bool sessaoPreenchida(Session sessao) {
    return sessao.nome != null && sessao.email != null && sessao.ra != null;
  }

  Future<void> initializeRideLists() async {
    print('Entrei');
    rideLists = await RideDao().listarTodasCorridas();
    if (rideLists != null) {
      print('ESSA É A RIDELIST: $rideLists');
      for (Ride ride in rideLists!) {
        Session sessao = Session();
        RideWidget rideWidget;
        if (sessaoPreenchida(sessao)) {
          rideWidget = RideWidget(ride, sessao.ra!);
        } else {
          rideWidget = RideWidget(ride, "");
        }
        // Crie o objeto RideWidget com base no objeto Ride
        rideWidgetList.add(
            rideWidget); // Adicione o objeto RideWidget na lista rideWidgetList
      }
    }

    print('Elementos da lista: $rideWidgetList');
    notifyListeners();
  }

  UnmodifiableListView<RideWidget> get list {
    if (rideWidgetList.isNotEmpty) {
      return UnmodifiableListView(rideWidgetList);
    } else {
      print("Lista vazia");
      return UnmodifiableListView([]);
    }
  }

  saveRide(Ride newRides) {
    RideDao().saveRide(newRides);
    notifyListeners();
  }

  updateRide(int id, String raCaroner) {
    RideDao().updateRidePassengers(id, raCaroner);
    notifyListeners();
  }
}
