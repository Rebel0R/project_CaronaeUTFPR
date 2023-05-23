//utilizar essa classe para ter um controle de sessões
import '../components/user_components.dart';

class Session {
  String? nome;
  String? email;
  String? ra;

  static final Session _instancia = Session._construtorPrivado();

  factory Session() {
    return _instancia;
  }

  Session._construtorPrivado();
}
