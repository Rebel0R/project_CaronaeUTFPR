class Ride {
  String nameDriver;
  String raDriver;
  DateTime date;
  String hour;
  String locationStart;
  String locationEnd;
  double value;
  String namePassengers = '';
  int numberPassengers;
  int id = -1;

  Ride(
      {required this.nameDriver,
      required this.raDriver,
      required this.date,
      required this.hour,
      required this.locationStart,
      required this.locationEnd,
      required this.value,
      required this.numberPassengers});
}
