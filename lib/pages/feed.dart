import 'package:flutter/material.dart';
import 'package:project_caronae/components/ride_component.dart';
import 'package:project_caronae/components/ride_widget_component.dart';
import 'package:project_caronae/data/ride_data.dart';
import 'package:provider/provider.dart';

import '../components/user_components.dart';

class Feed extends StatefulWidget {
  final String start;
  final String end;
  User authenticatedUser;
  Feed(
      {Key? key,
      required this.start,
      required this.end,
      required this.authenticatedUser})
      : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  DateTime now = DateTime.now();

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
            'De: ${widget.start} Para: ${widget.end}',
            style: TextStyle(
              color: Color(0xFFFFF4DF),
              fontFamily: 'Roboto',
            ),
          ),
        ),
        body: Consumer<RideData>(builder: (context, rides, child) {
          // Obtenha a instância correta do RideData usando Provider.of
          final rideData = Provider.of<RideData>(context);
          return rideData.list.isEmpty
              ? ListTile(
                  title: Text('Nenhuma carona encontrada'),
                )
              : ListView.builder(
                  itemCount: rideData.list.length,
                  itemBuilder: (_, index) {
                    return (rideData.list[index].ride.locationStart ==
                                widget.start &&
                            rideData.list[index].ride.locationEnd ==
                                widget.end &&
                            rideData.list[index].ride.date.day == now.day &&
                            rideData.list[index].ride.date.month == now.month &&
                            rideData.list[index].ride.date.year == now.year)
                        ? RideWidget(
                            Ride(
                              nameDriver: rideData.list[index].ride.nameDriver,
                              raDriver: rideData.list[index].ride.raDriver,
                              date: rideData.list[index].ride.date,
                              hour: rideData.list[index].ride.hour,
                              locationStart:
                                  rideData.list[index].ride.locationStart,
                              locationEnd:
                                  rideData.list[index].ride.locationEnd,
                              value: rideData.list[index].ride.value,
                              numberPassengers:
                                  rideData.list[index].ride.numberPassengers,
                            ),
                            widget.authenticatedUser.ra,
                          )
                        : SizedBox(
                            height: 0,
                          );
                  },
                );
        }));
  }
}
