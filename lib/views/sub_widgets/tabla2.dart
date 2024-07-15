import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VerUbicacion2 extends StatefulWidget {
  final String codigoSba;
  const VerUbicacion2({Key? key, required this.codigoSba}) : super(key: key);

  @override
  _VerUbicacionState createState() => _VerUbicacionState();
}

class _VerUbicacionState extends State<VerUbicacion2> {
  final TextEditingController _ubicacionController = TextEditingController();
  final TextEditingController _zonaController = TextEditingController();
  final TextEditingController _standController = TextEditingController();
  final TextEditingController _colController = TextEditingController();
  final TextEditingController _filController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _imgController = TextEditingController();

  List<dynamic> jsonUbic = [];

  @override
  void initState() {
    super.initState();
    obtenerDatosUbicacion(widget.codigoSba);
  }

  Future<void> obtenerDatosUbicacion(String codigoSba) async {
    try {
      if (codigoSba.isNotEmpty) {
        final urlUbi =
            'http://190.107.181.163:81/amq/flutter_ajax_ubi.php?search=$codigoSba';
        final response = await http.get(Uri.parse(urlUbi));
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            jsonUbic = data is List<dynamic> ? data : [];
          });
        } else {
          setState(() {
            jsonUbic = [];
          });
          print(
              'Error al consumir el API. Código de estado: ${response.statusCode}');
        }
      } else {
        setState(() {
          jsonUbic = [];
        });
        print('Código SBA vacío');
      }
    } catch (e) {
      setState(() {
        jsonUbic = [];
      });
      print('Error: $e');
    }
  }

  void mostrarFormularioUbicacion({Map<String, dynamic>? mapUbicacion}) {
    if (mapUbicacion != null) {
      _ubicacionController.text = mapUbicacion['Ubicacion'] ?? '';
      _zonaController.text = mapUbicacion['Zona'] ?? '';
      _standController.text = mapUbicacion['Stand'] ?? '';
      _colController.text = mapUbicacion['col'] ?? '';
      _filController.text = mapUbicacion['fil'] ?? '';
      _cantidadController.text = mapUbicacion['Cantidad'] ?? '';
      _usuarioController.text = mapUbicacion['usuario'] ?? '';
      _imgController.text = mapUbicacion['Img'] ?? '';
    } else {
      _clearTextControllers();
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(mapUbicacion == null
              ? 'Agregar Ubicación'
              : 'Actualizar Ubicación'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _ubicacionController,
                  decoration: InputDecoration(labelText: 'Ubicación'),
                ),
                TextField(
                  controller: _zonaController,
                  decoration: InputDecoration(labelText: 'Zona'),
                ),
                TextField(
                  controller: _standController,
                  decoration: InputDecoration(labelText: 'Stand'),
                ),
                TextField(
                  controller: _colController,
                  decoration: InputDecoration(labelText: 'Col'),
                ),
                TextField(
                  controller: _filController,
                  decoration: InputDecoration(labelText: 'Fila'),
                ),
                TextField(
                  controller: _usuarioController,
                  decoration: InputDecoration(labelText: 'Usuario'),
                ),
                TextField(
                  controller: _cantidadController,
                  decoration: InputDecoration(labelText: 'Cantidad'),
                ),
                TextField(
                  controller: _imgController,
                  decoration: InputDecoration(labelText: 'Img'),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (mapUbicacion == null) {
                  enviarData();
                } else {
                  final updatedUbicacion = {
                    'id': mapUbicacion['id'],
                    'usuario': _usuarioController.text,
                    'Ubicacion': _ubicacionController.text,
                    'Zona': _zonaController.text,
                    'Stand': _standController.text,
                    'col': _colController.text,
                    'fil': _filController.text,
                    'Cantidad': _cantidadController.text,
                    'Img': _imgController.text
                  };
                  _actualizarData(updatedUbicacion);
                }
                Navigator.of(context).pop();
              },
              child: Text(mapUbicacion == null ? 'Crear' : 'Actualizar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void _clearTextControllers() {
    _ubicacionController.clear();
    _zonaController.clear();
    _standController.clear();
    _colController.clear();
    _filController.clear();
    _cantidadController.clear();
    _usuarioController.clear();
    _imgController.clear();
  }

  Future<void> enviarData() async {
    try {
      final sbaCodigoUbi = widget.codigoSba;
      final url = 'http://190.107.181.163:81/amq/flutter_ajax_add.php';

      final response = await http.post(Uri.parse(url), body: {
        'search': sbaCodigoUbi,
        'ubicacion': _ubicacionController.text,
        'zona': _zonaController.text,
        'stand': _standController.text,
        'col': _colController.text,
        'fil': _filController.text,
        'cantidad': _cantidadController.text,
        'usuario': _usuarioController.text,
        'img': _imgController.text,
      });

      if (response.statusCode == 200) {
        final newData = {
          'Ubicacion': _ubicacionController.text,
          'Zona': _zonaController.text,
          'Stand': _standController.text,
          'col': _colController.text,
          'fil': _filController.text,
          'Cantidad': _cantidadController.text,
          'usuario': _usuarioController.text,
          'Img': _imgController.text,
        };
        setState(() {
          jsonUbic.add(newData);
          _clearTextControllers();
        });
        print(jsonUbic);
        print(newData);
      } else {
        print('Error al enviar datos a la API. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _actualizarData(Map<String, dynamic> ubicacion) async {
    try {
      final url = 'http://190.107.181.163:81/amq/flutter_ajax_edit.php';

      final response = await http.put(Uri.parse(url), body: {
        'id': ubicacion['id'] ?? '',
        'usuario': ubicacion['usuario'] ?? '',
        'Ubicacion': ubicacion['Ubicacion'] ?? '',
        'Zona': ubicacion['Zona'] ?? '',
        'Stand': ubicacion['Stand'] ?? '',
        'col': ubicacion['col'] ?? '',
        'fil': ubicacion['fil'] ?? '',
        'Cantidad': ubicacion['Cantidad'] ?? '',
        'Img': ubicacion['Img'] ?? '',
      });

      if (response.statusCode == 200) {
        print('Respuesta del servidor: ${response.body}');

        setState(() {
          final index = jsonUbic
              .indexWhere((element) => element['id'] == ubicacion['id']);
          if (index != -1) {
            jsonUbic[index] = ubicacion;
            _clearTextControllers();
          }
          print('Datos actualizados en el estado: $ubicacion');
        });
      } else {
        print('Error al actualizar la ubicación. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Ver Ubicación'),
        backgroundColor: Color.fromARGB(255, 173, 192, 197),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://peruoffset.pe/assets/images/iconos/logo-peruoffset.png'),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: jsonUbic.length,
                    itemBuilder: (context, index) {
                      final ubicacion = jsonUbic[index];
                      return Card(
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, size: 24),
                                    onPressed: () {
                                      mostrarFormularioUbicacion(mapUbicacion: ubicacion);
                                    },
                                  ),
                                ],
                              ),
                              Text('Ubicación: ${ubicacion['Ubicacion']}'),
                              Text('Zona: ${ubicacion['Zona']}'),
                              Text('Stand: ${ubicacion['Stand']}'),
                              Text('Col: ${ubicacion['col']}'),
                              Text('Fila: ${ubicacion['fil']}'),
                              Text('Cantidad: ${ubicacion['Cantidad']}'),
                              Text('Usuario: ${ubicacion['usuario']}'),
                              Image.network(
                                ubicacion['Img'],
                                height: 100,
                                width: 100,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                mostrarFormularioUbicacion();
              },
              child: Icon(Icons.add),
              backgroundColor: Color.fromARGB(255, 173, 192, 197),
            ),
          ),
        ],
      ),
    );
  }
}
