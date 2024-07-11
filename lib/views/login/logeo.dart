import 'package:flutter/material.dart';
import 'package:sistema_almacenes/views/Layout/gift.dart';
import 'package:sistema_almacenes/views/index.dart';
import 'package:sistema_almacenes/views/login/class_decorations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class LoginVista extends StatefulWidget {
  const LoginVista({super.key});

  @override
  _LoginVistaState createState() => _LoginVistaState();
}

class _LoginVistaState extends State<LoginVista> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<String?> iniciarSesion(String usuario, String contrasena) async {
    final url = 'http://190.107.181.163:81/amq/flutter_ajax_token.php';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {'uss': usuario, 'pass': contrasena},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return data['token'];
        } else {
          return null;
        }
      } else {
        print('Error al iniciar sesión. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [cajapurpura(size), iconopersona(), loginform(context)],
          ),
        ),
      ),
    );
  }

  SingleChildScrollView loginform(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 250,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      offset: Offset(0, 5))
                ]),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Text('Iniciar Sesión',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                Container(
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 70,
                        ),
                        TextFormField(
                            controller: _numeroController,
                            autocorrect: false,
                            keyboardType: TextInputType.number,
                            decoration: InputDecorations.inputDecoration(
                                hintText: 'Ingrese su número',
                                labelText: 'Número de usuario',
                                icono: Icon(Icons.person)),
                            /*validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingrese su número de usuario';
                              }
                              if (value.length < 8) {
                                return 'El número debe tener al menos 8 dígitos';
                              }
                              return null;
                            }*/
                            ),
                        const SizedBox(
                          height: 100,
                        ),
                        TextFormField(
                            controller: _passwordController,
                            autocorrect: false,
                            obscureText: true,
                            decoration: InputDecorations.inputDecoration(
                                hintText: '*********',
                                labelText: 'Contraseña',
                                icono: Icon(Icons.lock_outlined)),
                            /*validator: (value) {
                              return (value != null && value.length >= 4)
                                  ? null
                                  : 'La contraseña debe ser mayor o igual a los 4 caracteres';
                            }*/
                            ),
                        SizedBox(height: 200),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          disabledColor: Colors.grey,
                          onPressed: () async {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> FadeinImage()));
                            
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> IndexPag()));
                           /* if (_formKey.currentState!.validate()) {
                              final token = await iniciarSesion(
                                  _numeroController.text, _passwordController.text);
                              if (token != null) {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> PantallaInicioAmp()));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text('Error al iniciar sesión')));
                              }
                            }*/
                          },
                          color: Colors.deepPurple,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                            child: Text(
                              'Ingresar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Crear una nueva cuenta',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  SafeArea iconopersona() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        width: double.infinity,
        child: const Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }

  Container cajapurpura(Size size) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(24, 128, 197, 1),
        Color.fromRGBO(90, 70, 178, 1)
      ])),
      width: double.infinity,
      height: size.height * 0.4,
      child: Stack(
        children: [
          Positioned(
            child: burbuja(),
            top: 90,
            left: 30,
          ),
          Positioned(child: burbuja(), top: 90, left: 30),
          Positioned(child: burbuja(), top: -40, left: -30),
          Positioned(child: burbuja(), top: -50, right: -20),
          Positioned(child: burbuja(), bottom: -50, left: 10),
          Positioned(child: burbuja(), bottom: 120, right: 20),
        ],
      ),
    );
  }

  Container burbuja() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromRGBO(255, 255, 255, 0.05)),
    );
  }
}


