
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  String _id = '';
  String _ubicacion = '';
  String _zona = '';
  String _stand = '';
  String _col = '';
  String _fil = '';
  String _cantidad = '';
  String _img = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insertar Ubicación'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //... (rest of the form fields)
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    try {
                      final ubicacion = Ubicacion(
                        id: _id,
                        ubicacion: _ubicacion,
                        zona: _zona,
                        stand: _stand,
                        col: _col,
                        fil: _fil,
                        cantidad: _cantidad,
                        img: _img,
                      );

                      final jsonData = jsonEncode(ubicacion.toJson());

                      final url = 'http://190.107.181.163:81/amq/flutter_ajax_add.php?search=757';
                      final response = await http.post(
                        Uri.parse(url),
                        headers: {
                          'Content-Type': 'application/json',
                        },
                        body: jsonData,
                      );

                      if (response.statusCode == 200) {
                        print('Datos insertados correctamente');
                      } else {
                        print('Error al insertar datos: ${response.statusCode}');
                      }
                    } catch (e) {
                      print('Error: $e');
                    }
                  }
                },
                child: Text('Insertar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Ubicacion {
  final String id;
  final String ubicacion;
  final String zona;
  final String stand;
  final String col;
  final String fil;
  final String cantidad;
  final String img;

  Ubicacion({
    required this.id,
    required this.ubicacion,
    required this.zona,
    required this.stand,
    required this.col,
    required this.fil,
    required this.cantidad,
    required this.img,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ubicacion': ubicacion,
      'zona': zona,
      'tand': stand,
      'col': col,
      'fil': fil,
      'cantidad': cantidad,
      'img': img,
    };
  }
}