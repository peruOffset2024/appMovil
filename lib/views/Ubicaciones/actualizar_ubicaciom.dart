import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InsertarUbicacion extends StatefulWidget {
  const InsertarUbicacion({super.key});

  @override
  State<InsertarUbicacion> createState() => _InsertarUbicacionState();
}

class _InsertarUbicacionState extends State<InsertarUbicacion> {
  final TextEditingController _insetarUbiController = TextEditingController();
  final TextEditingController _zonaController = TextEditingController();
  final TextEditingController _standController = TextEditingController();
  final TextEditingController _colController = TextEditingController();
  final TextEditingController _filController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  List<dynamic> jsonUbic = [];

  Future<void> insertarData() async {
    try {
      final codigosba = _insetarUbiController.text;
      if (codigosba.isNotEmpty) {
        final urlUbi =
            'http://190.107.181.163:81/amq/flutter_ajax_ubi.php?search=$codigosba';
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
          print('Error al consumir el API');
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

  Future<void> enviarData() async {
    try {
      final sbaCodigo = _insetarUbiController.text;
      final url = 'http://190.107.181.163:81/amq/flutter_ajax_add.php?search=$sbaCodigo';
      final response = await http.post(Uri.parse(url), body: {
        'Ubicacion': _insetarUbiController.text,
        'Zona': _zonaController.text,
        'Stand': _standController.text,
        'col': _colController.text,
        'fil': _filController.text,
        'Cantidad': _cantidadController.text,
      });

      if (response.statusCode == 200) {
        final newData = {
          'Ubicacion': _insetarUbiController.text,
          'Zona': _zonaController.text,
          'Stand': _standController.text,
          'col': _colController.text,
          'fil': _filController.text,
          'Cantidad': _cantidadController.text,
          'Img': '',
        };
        setState(() {
          jsonUbic.add(newData);
          _clearTextControllers();
        });
      } else {
        print('Error al enviar datos a la API');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> eliminarData(String id) async {
    try {
      final url = 'http://190.107.181.163:81/amq/flutter_ajax_delete.php?id=$id';
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          jsonUbic.removeWhere((element) => element['id'] == id);
        });
      } else {
        print('Error al eliminar la ubicación');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> actualizarData(Map<String, dynamic> ubicacion) async {
    try {
      final url = 'http://190.107.181.163:81/amq/flutter_ajax_update.php';
      final response = await http.put(Uri.parse(url), body: ubicacion);

      if (response.statusCode == 200) {
        setState(() {
          final index = jsonUbic.indexWhere((element) => element['id'] == ubicacion['id']);
          if (index != -1) {
            jsonUbic[index] = ubicacion;
            _clearTextControllers();
          }
        });
      } else {
        print('Error al actualizar la ubicación');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _clearTextControllers() {
    _zonaController.clear();
    _standController.clear();
    _colController.clear();
    _filController.clear();
    _cantidadController.clear();
  }

  void mostrarFormularioUbicacion({Map<String, dynamic>? ubicacion}) {
    if (ubicacion != null) {
      _zonaController.text = ubicacion['Zona'];
      _standController.text = ubicacion['Stand'];
      _colController.text = ubicacion['col'];
      _filController.text = ubicacion['fil'];
      _cantidadController.text = ubicacion['Cantidad'];
    } else {
      _clearTextControllers();
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(ubicacion == null ? 'Agregar Ubicación' : 'Actualizar Ubicación'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                  controller: _cantidadController,
                  decoration: InputDecoration(labelText: 'Cantidad'),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (ubicacion == null) {
                  enviarData();
                } else {
                  final updatedUbicacion = {
                    'id': ubicacion['id'],
                    'Ubicacion': _insetarUbiController.text,
                    'Zona': _zonaController.text,
                    'Stand': _standController.text,
                    'col': _colController.text,
                    'fil': _filController.text,
                    'Cantidad': _cantidadController.text,
                  };
                  actualizarData(updatedUbicacion);
                }
                Navigator.of(context).pop();
              },
              child: Text(ubicacion == null ? 'Crear' : 'Actualizar'),
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
        backgroundColor: Color(0xFF6CA8F1),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 200,
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
                SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {
                      insertarData();
                    },
                    child: Text('Buscar')),
                SizedBox(width: 290),
                ElevatedButton(
                  onPressed: () => mostrarFormularioUbicacion(),
                  child: Text('Agregar Ubicación', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: jsonUbic.length,
              itemBuilder: (context, index) {
                final ubicacion = jsonUbic[index];
                return ListTile(
                  title: Text('Ubicación: ${ubicacion['Ubicacion']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Zona: ${ubicacion['Zona']}'),
                      Text('Stand: ${ubicacion['Stand']}'),
                      Text('Columna: ${ubicacion['col']}'),
                      Text('Fila: ${ubicacion['fil']}'),
                      Text('Cantidad: ${ubicacion['Cantidad']}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          mostrarFormularioUbicacion(ubicacion: ubicacion);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          eliminarData(ubicacion['id'].toString());
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
