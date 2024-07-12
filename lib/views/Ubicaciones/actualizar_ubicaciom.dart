import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InsertarUbicacion extends StatefulWidget {
  const InsertarUbicacion({super.key});

  @override
  State<InsertarUbicacion> createState() => _InsertarUbicacionState();
}

class _InsertarUbicacionState extends State<InsertarUbicacion> {
  final TextEditingController _ubicacionController = TextEditingController();
  final TextEditingController _insetarUbiController =
      TextEditingController(); // SBA de búsqueda
  final TextEditingController _zonaController = TextEditingController();
  final TextEditingController _standController = TextEditingController();
  final TextEditingController _colController = TextEditingController();
  final TextEditingController _filController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _imgController = TextEditingController();
  List<dynamic> jsonUbic = [];

  void _clearTextControllers() {
    _zonaController.clear();
    _standController.clear();
    _colController.clear();
    _filController.clear();
    _cantidadController.clear();
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
                  controller: _insetarUbiController,
                  decoration: InputDecoration(labelText: 'Código SBA'),
                  enabled: false,
                ),
                TextField(
                  controller: _ubicacionController,
                  decoration: InputDecoration(labelText: 'Ubicacion'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Gestión de Ubicaciones'),
        backgroundColor: Color.fromARGB(255, 173, 192, 197),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://peruoffset.pe/assets/images/iconos/logo-peruoffset.png'),
               
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.1),
                  BlendMode.dstATop,
                ),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: jsonUbic.length,
                    itemBuilder: (context, index) {
                      final ubicacion = jsonUbic[index]; // ubicacion de
                      return Card(
                        margin: EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ubicación: ${ubicacion['Ubicacion'] ?? ''}',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Divider(),
                              _buildInfoRow('ID', ubicacion['id'] ?? ''),
                              _buildInfoRow('Zona', ubicacion['Zona'] ?? ''),
                              _buildInfoRow('Stand', ubicacion['Stand'] ?? ''),
                              _buildInfoRow('Columna', ubicacion['col'] ?? ''),
                              _buildInfoRow('Fila', ubicacion['fil'] ?? ''),
                              _buildInfoRow('Cantidad', ubicacion['Cantidad'] ?? ''),
                              _buildInfoRow('Usuario', ubicacion['usuario'] ?? ''),
                             
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      size: 40,
                                      Icons.edit),
                                    onPressed: () {
                                      mostrarFormularioUbicacion(
                                          mapUbicacion: ubicacion);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        width: 300,
                        height: 50,
                        child: TextField(
                          controller: _insetarUbiController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              hintText: 'Ingresa código SBA',
                              prefixIcon: Icon(Icons.search)),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      SizedBox(
                        height: 60,
                        width: 120,
                        child: ElevatedButton(
                            onPressed: () {
                              obtenerDatosUbicacion();
                            },
                            child: Text(
                              'Buscar',
                            )),
                      ),
                      SizedBox(width: 150),
                      SizedBox(
                        width: 120,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () => mostrarFormularioUbicacion(),
                          child: Text(
                            style: TextStyle(color: Colors.white),
                            'Agregar +'),
                            style: ElevatedButton.styleFrom(
                              
                              backgroundColor: Colors.blue, // Color del botón
                              // Color del texto
                              elevation: 10, // Elevación del botón
                            ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Future<void> enviarData() async {
    try {
      final sbaCodigoUbi = _insetarUbiController.text;
      final url = 'http://190.107.181.163:81/amq/flutter_ajax_add.php';

      // Imprimir los valores antes de enviar
      print('Enviando datos:');
      print('ubicacion: ${_ubicacionController.text}');
      print('zona: ${_zonaController.text}');
      print('stand: ${_standController.text}');
      print('col: ${_colController.text}');
      print('fil: ${_filController.text}');
      print('cantidad: ${_cantidadController.text}');
      print('usuario: ${_usuarioController.text}');
      print('img: ${_imgController.text}');

      final response = await http.post(Uri.parse(url), body: {
        'search': sbaCodigoUbi,
        'ubicacion': _ubicacionController.text,
        'zona': _zonaController.text,
        'stand': _standController.text,
        'col': _colController.text,
        'fil': _filController.text,
        'cantidad': _cantidadController.text,
        'usuario': _usuarioController.text,
        'img': _imgController.text
      });

      if (response.statusCode == 200) {
        final newData = {
          'Ubicacion': _ubicacionController.text,
          'zona': _zonaController.text,
          'stand': _standController.text,
          'col': _colController.text,
          'fil': _filController.text,
          'cantidad': _cantidadController.text,
          'usuario': _usuarioController.text,
          'img': _imgController.text
        };
        setState(() {
          jsonUbic.add(newData);

          _clearTextControllers();
          obtenerDatosUbicacion();
        });
        print(jsonUbic);
        print(newData);
      } else {
        print(
            'Error al enviar datos a la API. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _actualizarData(Map<String, dynamic> ubicacion) async {
    try {
      final url = 'http://190.107.181.163:81/amq/flutter_ajax_edit.php';

      // Imprimir los datos que se van a enviar para actualizar
      print('Datos para actualizar: $ubicacion');

      final response = await http.put(Uri.parse(url), body: {
        'id': ubicacion['id'] ?? '',
        'usuario': ubicacion['usuario'] ?? '',
        'Ubicacion': ubicacion['Ubicacion'] ?? '',
        'Zona': ubicacion['Zona'] ?? '',
        'Stand': ubicacion['Stand'] ?? '',
        'col': ubicacion['col'] ?? '',
        'fil': ubicacion['fil'] ?? '',
        'Cantidad': ubicacion['Cantidad'] ?? '',
        'Img': ubicacion['Img'] ?? ''
      });

      if (response.statusCode == 200) {
        // Imprimir la respuesta del servidor
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
        print(
            'Error al actualizar la ubicación. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> obtenerDatosUbicacion() async {
    try {
      final codigosba = _insetarUbiController.text;
      if (codigosba.isNotEmpty) {
        final urlUbi =
            'http://190.107.181.163:81/amq/flutter_ajax_ubi.php?search=$codigosba';
        final response = await http.get(Uri.parse(urlUbi));
        if (response.statusCode == 200) {
          print('Response body: ${response.body}');
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
}
