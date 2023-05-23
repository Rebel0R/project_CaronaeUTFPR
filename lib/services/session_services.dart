//utilizar essa classe para ter um controle de sessões
class Session {
  String fullname;
  String email;
  String ra;
  String password;
  String token;

  Session(
      {required this.fullname,
      required this.email,
      required this.ra,
      required this.password,
      required this.token});
}
