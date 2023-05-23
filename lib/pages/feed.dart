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
          return rides.list.isEmpty
              ? ListTile(
                  title: Text('Nenhuma carona encontrada'),
                )
              : ListView.builder(
                  itemCount: rides.list.length,
                  itemBuilder: (_, index) {
                    return (rides.list[index].ride.locationStart ==
                                widget.start &&
                            rides.list[index].ride.locationEnd == widget.end)
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
                            widget.authenticatedUser.ra)
                        : SizedBox(
                            height: 0,
                          );
                  },
                );
        }));
  }
}
