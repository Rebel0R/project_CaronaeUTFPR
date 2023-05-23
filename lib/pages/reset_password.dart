import 'package:flutter/material.dart';
import 'package:project_caronae/components/user_components.dart';
import 'package:project_caronae/data/users_dao_data.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
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
                      text: 'Esqueceu sua senha?\n',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 30,
                        color: Color(0xFFFF8D21),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Atualize sua ',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 30,
                            color: Color(0xFFFF8D21),
                          ),
                        ),
                        TextSpan(
                          text: 'senha',
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
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'E-mail inválido ou inexistente';
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'E-mail:',
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
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Senha atual:',
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
                        return 'Nova Senha inválida ou inexistente!';
                      }
                    },
                    controller: newPasswordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nova Senha:',
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
                    width: 180,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          User? authenticatedUser = await UserDao()
                              .updateUserPassword(
                                  emailController.text,
                                  passwordController.text,
                                  newPasswordController.text);
                          if (authenticatedUser != null) {
                            print('Senha alterada com sucesso!');
                            Navigator.pop(context);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Dados atualizados'),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Algo deu errado'),
                              ),
                            );
                          }
                          /*for (User user in widget.usersData) {
                            if (user.email == emailController.text &&
                                user.password == passwordController.text) {
                              user.password = newPasswordController.text;
                              Navigator.pop(context);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Dados atualizados'),
                                ),
                              );
                            }
                          }*/
                        }
                      },
                      child: Text(
                        'Nova Senha',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
