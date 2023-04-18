import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_caronae/components/user.dart';
import 'package:project_caronae/pages/login_app.dart';

class RegisterApp extends StatefulWidget {
  List<User> usersRegister;
  RegisterApp({Key? key, required this.usersRegister}) : super(key: key);

  @override
  State<RegisterApp> createState() => _RegisterAppState();
}

class _RegisterAppState extends State<RegisterApp> {
  bool obscureText = false;
  TextEditingController fullnameController = TextEditingController();
  TextEditingController raController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool searchUser(User newUser) {
    for (User user in widget.usersRegister) {
      if (user.fullname == newUser.fullname) {
        return true;
      }
      if (user.email == newUser.email) {
        return true;
      }
      if (user.ra == newUser.ra) {
        return true;
      }
    }
    return false;
  }

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
                  padding: const EdgeInsets.only(top: 70, bottom: 25),
                  child: Container(
                    height: 80,
                    width: 280,
                    child: Image.asset('images/logoOrange.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 20, right: 20, bottom: 8),
                  child: TextFormField(
                      controller: fullnameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 5) {
                          return ('Insera seu Nome Completo');
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nome Completo:',
                          labelStyle: TextStyle(
                              color: Color(0XffFF8D21), fontFamily: 'Roboto'),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(0XffFF8D21))))),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 20, right: 20, bottom: 8),
                  child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty ||
                            value.length != 8 ||
                            value[0] != 'a') {
                          return ('RA inválido ou inexistente');
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
                              borderSide:
                                  BorderSide(color: Color(0XffFF8D21))))),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 20, right: 20, bottom: 8),
                  child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !value.contains('@') ||
                            value.length < 5) {
                          return ('E-mail inválido ou inexistente');
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'E-mail:',
                          labelStyle: TextStyle(
                              color: Color(0XffFF8D21), fontFamily: 'Roboto'),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Color(0XffFF8D21))))),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 20, right: 20, bottom: 8),
                  child: TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ('Senha inválida ou inexistente');
                        }
                        return null;
                      },
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
                              borderSide:
                                  BorderSide(color: Color(0XffFF8D21))))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 14),
                  child: Container(
                    width: 270,
                    height: 53,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          bool userExist = searchUser(User(
                              fullname: fullnameController.text,
                              email: emailController.text,
                              ra: raController.text,
                              password: passwordController.text));

                          if (!userExist) {
                            widget.usersRegister.add(User(
                                fullname: fullnameController.text,
                                email: emailController.text,
                                ra: raController.text,
                                password: passwordController.text));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Cadastrado com sucesso!'),
                              ),
                            );

                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Usuário já cadastrado')));
                          }
                        }
                      },
                      child: Text(
                        'Cadastrar',
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
                Container(
                  child: RichText(
                      text: TextSpan(
                          text: 'Já possuí uma conta? ',
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginApp(
                                          usersData: widget.usersRegister)));
                            },
                        )
                      ])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
