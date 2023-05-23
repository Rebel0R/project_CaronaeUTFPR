import 'package:flutter/material.dart';

class Ride extends StatefulWidget {
  final String nameDriver;
  final DateTime date;
  final String hour;
  final String locationStart;
  final String locationEnd;
  final double value;
  int passenger;

  Ride(this.date, this.hour, this.locationStart, this.locationEnd,
      this.nameDriver, this.passenger, this.value,
      {Key? key})
      : super(key: key);

  @override
  State<Ride> createState() => _RideState();
}

class _RideState extends State<Ride> {
  void attPassenger() {
    setState(() {
      if (widget.passenger > 0) {
        widget.passenger--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      '${widget.date.day}/${widget.date.month}',
                      style: TextStyle(color: Color(0xFFFFF4DF), fontSize: 15),
                    ),
                    Text(
                      widget.hour,
                      style: TextStyle(color: Color(0xFFFFF4DF), fontSize: 15),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      maxLines: 2,
                      '${widget.locationStart}',
                      style: TextStyle(
                        color: Color(0xFFFFF4DF),
                        fontSize: 16,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Color(0xFFFFF4DF),
                      size: 20,
                    ),
                    Text(
                      maxLines: 2,
                      '${widget.locationEnd}',
                      style: TextStyle(color: Color(0xFFFFF4DF), fontSize: 16),
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
                          '${widget.value}',
                          style:
                              TextStyle(color: Color(0xFFFFF4DF), fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.person, color: Color(0xFFFFF4DF)),
                        Text(
                          '${widget.passenger}',
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
                  widget.nameDriver,
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
                      attPassenger();
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
