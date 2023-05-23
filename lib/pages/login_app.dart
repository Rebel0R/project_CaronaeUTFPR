import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_caronae/components/user_components.dart';
import 'package:project_caronae/pages/reset_password.dart';
import 'package:project_caronae/pages/search_ride.dart';
import 'package:project_caronae/data/users_dao_data.dart';

class LoginApp extends StatefulWidget {
  LoginApp({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  TextEditingController raController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = false;

  final _formKey = GlobalKey<FormState>();

  // User searchUser(String ra, String password) {
  //   for (User user in widget.usersData) {
  //     if (user.ra == ra && user.password == password) {
  //       return user;
  //     }
  //   }
  //   return User(fullname: '', email: '', ra: '', password: '');
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Container(
          width: 412,
          height: 707,
          color: Color(0xFFFFF4DF),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 75, bottom: 20),
                  child: Container(
                    height: 80,
                    width: 280,
                    child: Image.asset('images/logoOrange.png'),
                  ),
                ),
                Container(
                  child: RichText(
                    text: TextSpan(
                      text: 'Bem vindo de volta\n',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 30,
                        color: Color(0xFFFF8D21),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Faça seu ',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 30,
                            color: Color(0xFFFF8D21),
                          ),
                        ),
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF8D21),
                          ),
                        ),
                        TextSpan(
                          text: ', Caroner!',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 30,
                            color: Color(0xFFFF8D21),
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 40, left: 20, right: 20, bottom: 8),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'RA inválido ou inexistente!';
                      }
                      return null;
                    },
                    controller: raController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Registro de Aluno:',
                        labelStyle: TextStyle(
                            color: Color(0XffFF8D21), fontFamily: 'Roboto'),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0XffFF8D21)))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 20, right: 20, bottom: 8),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Senha inválida ou inexistente!';
                      }
                    },
                    controller: passwordController,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscureText =
                                  !obscureText; // alterna a visibilidade da senha
                            });
                          },
                          child: Icon(obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        suffixIconColor: Color(0xFFFF8D21),
                        border: OutlineInputBorder(),
                        labelText: 'Senha:',
                        labelStyle: TextStyle(
                            color: Color(0XffFF8D21), fontFamily: 'Roboto'),
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0XffFF8D21)))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 14),
                  child: Container(
                    width: 140,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          User? authenticatedUser =
                              await UserDao().encontrarUserBanco(
                            raController.text,
                            passwordController.text,
                          );
                          if (authenticatedUser != null) {
                            print('Login realizado com sucesso!');
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchRide(
                                          authenticatedUser: authenticatedUser,
                                        )));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Dados inválidos'),
                              ),
                            );
                          }
                          /*User userExist = searchUser(
                              raController.text, passwordController.text);
                          if (userExist.fullname != '') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchRide(
                                        authenticatedUser: userExist,
                                        usersData: widget.usersData)));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Dados inválidos'),
                              ),
                            );
                          }*/
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 244, 223),
                            fontFamily: 'Roboto',
                            fontSize: 22),
                      ),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFFF7B00))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 8),
                  child: Container(
                    child: RichText(
                        text: TextSpan(
                            text: 'Esqueceu sua senha? ',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 255, 123, 0),
                            ),
                            children: <TextSpan>[
                          TextSpan(
                            text: 'Clique Aqui',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 123, 0)),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('Ir para Esqueceu a Senha!');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResetPassword()));
                              },
                          )
                        ])),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
