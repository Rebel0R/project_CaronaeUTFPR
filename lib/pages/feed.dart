import 'package:flutter/material.dart';
import 'package:project_caronae/components/ride.dart';
import 'package:project_caronae/data/ride_data.dart';
import 'package:provider/provider.dart';

class Feed extends StatefulWidget {
  final String start;
  final String end;
  const Feed({Key? key, required this.start, required this.end})
      : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
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
                    return (rides.list[index].locationStart == widget.start &&
                            rides.list[index].locationEnd == widget.end)
                        ? Ride(
                            rides.list[index].date,
                            rides.list[index].hour,
                            rides.list[index].locationStart,
                            rides.list[index].locationEnd,
                            rides.list[index].nameDriver,
                            rides.list[index].passenger,
                            rides.list[index].value)
                        : SizedBox(
                            height: 0,
                          );
                  },
                );
        }));
  }
}
