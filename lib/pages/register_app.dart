import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_caronae/components/user_components.dart';
import 'package:project_caronae/pages/login_app.dart';
import 'package:project_caronae/data/users_dao_data.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

class RegisterApp extends StatefulWidget {
  RegisterApp({Key? key}) : super(key: key);

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

  File? _selectedImage;
  String? base64Image;

  Future<void> _openCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });

      List<int> imageBytes = await _selectedImage!.readAsBytes();
      base64Image = base64Encode(imageBytes);
    }
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
                  padding: const EdgeInsets.only(top: 70, bottom: 10),
                  child: Container(
                    height: 80,
                    width: 280,
                    child: Image.asset('images/logoOrange.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 57, 57, 57),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _selectedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: Colors.white54,
                            ),
                            onPressed: _openCamera,
                          ),
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
                          UserDao().saveUser(User(
                              fullname: fullnameController.text,
                              email: emailController.text,
                              ra: raController.text,
                              password: passwordController.text,
                              profilePhoto: base64Image ?? ''));

                          if (UserDao().saveUser(User(
                                  fullname: fullnameController.text,
                                  email: emailController.text,
                                  ra: raController.text,
                                  password: passwordController.text,
                                  profilePhoto: base64Image ?? '')) ==
                              -1) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Usuário já cadastrado'),
                              ),
                            );
                          } else {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Cadastrado com sucesso!'),
                              ),
                            );
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
                                      builder: (context) => LoginApp()));
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
