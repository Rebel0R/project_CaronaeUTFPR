import 'package:project_caronae/components/ride.dart';

class User {
  String fullname;
  String email;
  String ra;
  String password;
  List<Ride> rides = [];

  User(
      {required this.fullname,
      required this.email,
      required this.ra,
      required this.password});
}
