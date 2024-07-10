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
  final TextEditingController _insetarUbiController = TextEditingController(); // Sba de busqueda
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

  void mostrarFormularioUbicacion({Map<String, dynamic>? ubicacion}) {
    if (ubicacion != null) {
      _ubicacionController.text = ubicacion['ubicacion'] ?? '';
      _zonaController.text = ubicacion['zona'] ?? '';
      _standController.text = ubicacion['stand'] ?? '';
      _colController.text = ubicacion['col'] ?? '';
      _filController.text = ubicacion['fil'] ?? '';
      _cantidadController.text = ubicacion['cantidad'] ?? '';
      _usuarioController.text = ubicacion['usuario'] ?? '';
      _imgController.text = ubicacion['img'] ?? '';
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
                if (ubicacion == null) {
                  enviarData();
                } else {
                  final updatedUbicacion = {
                    'id': ubicacion['id'],
                    'ubicacion': _ubicacionController.text,
                    'zona': _zonaController.text,
                    'stand': _standController.text,
                    'col': _colController.text,
                    'fil': _filController.text,
                    'cantidad': _cantidadController.text,
                    'usuario': _usuarioController.text,
                    'img': _imgController.text
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
                      obtenerDatosUbicacion();
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
                      Text('ID: ${ubicacion['id']}'),
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
        print('Error al enviar datos a la API. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  bool validateData(Map<String, dynamic> data) {
  // Validar que todos los campos necesarios no estén vacíos
  if (data['ubicacion'].isEmpty ||
      data['zona'].isEmpty ||
      data['stand'].isEmpty ||
      data['col'].isEmpty ||
      data['fil'].isEmpty ||
      data['cantidad'].isEmpty) {
    return false;
  }
  return true;
}

Future<void> actualizarData(Map<String, dynamic> ubicacion) async {
  try {
    final url = 'http://190.107.181.163:81/amq/flutter_ajax_update.php';

    final Map<String, dynamic> body = {
      'id': ubicacion['id'],
      'ubicacion': _ubicacionController.text,
      'zona': _zonaController.text,
      'stand': _standController.text,
      'col': _colController.text,
      'fil': _filController.text,
      'cantidad': _cantidadController.text,
      'usuario': _usuarioController.text,
      'Img': _imgController.text,
    };

    if (!validateData(body)) {
      print('Error: Datos inválidos');
      return;
    }

    print('Actualizando datos con el body: $body');

    final response = await http.put(Uri.parse(url), body: jsonEncode(body), headers: {
      'Content-Type': 'application/json',
    });

    print('Respuesta del servidor: ${response.body}');

    if (response.statusCode == 200) {
      obtenerDatosUbicacion(); // Refrescar después de actualizar datos
    } else {
      print('Error al actualizar la ubicación. Status code: ${response.statusCode}');
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
        obtenerDatosUbicacion();
      } else {
        print('Error al eliminar la ubicación. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> obtenerDatosUbicacion() async {
  try {
    final codigosba = _insetarUbiController.text;
    if (codigosba.isNotEmpty) {
      final urlUbi = 'http://190.107.181.163:81/amq/flutter_ajax_ubi.php?search=$codigosba';
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
        print('Error al consumir el API. Status code: ${response.statusCode}');
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
