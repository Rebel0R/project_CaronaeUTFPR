import 'package:flutter/material.dart';
import 'package:project_caronae/components/ride_component.dart';
import 'package:project_caronae/components/user_components.dart';
import 'package:provider/provider.dart';
import '../data/ride_data.dart';

class RideWidget extends StatefulWidget {
  Ride ride;
  String raUSer;
  RideWidget(this.ride, this.raUSer, {Key? key}) : super(key: key);

  @override
  State<RideWidget> createState() => _RideWidgetState();
}

class _RideWidgetState extends State<RideWidget> {
  late RideData allRides;
  // void attnumberPassengers() {
  //   setState(() {
  //     if (widget.ride.numberPassengers > 0) {
  //       widget.ride.numberPassengers--;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    allRides = context.watch<RideData>();
    //allRides.user = widget.authenticatedUser;
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 10, left: 20, right: 20),
      child: Container(
        alignment: Alignment.center,
        height: 140,
        width: 335,
        decoration: BoxDecoration(
            color: Color(0XFFFF7B00), borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      '${widget.ride.date.day}/${widget.ride.date.month}',
                      style: TextStyle(color: Color(0xFFFFF4DF), fontSize: 15),
                    ),
                    Text(
                      widget.ride.hour,
                      style: TextStyle(color: Color(0xFFFFF4DF), fontSize: 15),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      maxLines: 2,
                      '${widget.ride.locationStart}',
                      style: TextStyle(
                        color: Color(0xFFFFF4DF),
                        fontSize: 12,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Color(0xFFFFF4DF),
                      size: 20,
                    ),
                    Text(
                      maxLines: 2,
                      '${widget.ride.locationEnd}',
                      style: TextStyle(color: Color(0xFFFFF4DF), fontSize: 12),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          color: Color(0xFFFFF4DF),
                        ),
                        Text(
                          '${widget.ride.value}',
                          style:
                              TextStyle(color: Color(0xFFFFF4DF), fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.person, color: Color(0xFFFFF4DF)),
                        Text(
                          '${widget.ride.numberPassengers}',
                          style:
                              TextStyle(color: Color(0xFFFFF4DF), fontSize: 15),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  maxLines: 2,
                  widget.ride.nameDriver,
                  style: TextStyle(
                      color: Color(0xFFFFF4DF),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  width: 120,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      allRides.updateRide(widget.ride.id, widget.raUSer);
                      //attnumberPassengers();
                    },
                    child: Text(
                      'Reservar',
                      style: TextStyle(
                          color: Color(0XFFFF7B00),
                          fontFamily: 'Roboto',
                          fontSize: 22),
                    ),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFFFFF4DF))),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}