import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';

import 'package:sistema_almacenes/views/sub_widgets/tabla_ubicaciones.dart';
import 'package:sistema_almacenes/views/sub_widgets/tabla_almacen.dart';

class IndexPag extends StatefulWidget {
  const IndexPag({Key? key}) : super(key: key);

  @override
  State<IndexPag> createState() => _IndexPagState();
}

class _IndexPagState extends State<IndexPag> {
  TextEditingController _codigoSbaController = TextEditingController();
  List<dynamic> jsonData = [];
  List<dynamic> jsonDataUbi = [];

  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
        drawer: Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      UserAccountsDrawerHeader(
        accountName: Text("John Doe"),
        accountEmail: Text("johndoe@example.com"),
        currentAccountPicture: CircleAvatar(
          backgroundImage: NetworkImage("https://example.com/profile_picture.jpg"),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://example.com/background_image.jpg"),
            fit: BoxFit.fill,
          ),
        ),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text("Home"),
        onTap: () {
          // Update the state of the app
          // Then close the drawer
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text("Settings"),
        onTap: () {
          // Update the state of the app
          // Then close the drawer
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: Icon(Icons.help),
        title: Text("Help"),
        onTap: () {
          // Update the state of the app
          // Then close the drawer
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: Icon(Icons.info),
        title: Text("About"),
        onTap: () {
          // Show an about dialog
          showAboutDialog(
            context: context,
            applicationName: "My App",
            applicationVersion: "1.0.0",
            applicationLegalese: "Copyright 2023 My Company",
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.logout),
        title: Text("Log out"),
        onTap: () {
          // Log out the user
          // Then close the drawer
          Navigator.pop(context);
        },
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.language),
        title: Text("Language"),
        trailing: DropdownButton(
          value: "en",
          onChanged: (value) {
            // Update the language of the app
          },
          items: [
            DropdownMenuItem(
              child: Text("English"),
              value: "en",
            ),
            DropdownMenuItem(
              child: Text("Spanish"),
              value: "es",
            ),
            DropdownMenuItem(
              child: Text("French"),
              value: "fr",
            ),
          ],
        ),
      ),
      ListTile(
        leading: Icon(Icons.add),
        title: Text("Theme"),
        trailing: Switch(
          value: true,
          onChanged: (value) {
            // Update the theme of the app
          },
        ),
      ),
    ],
  ),
),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 231, 79, 112),
          title: Text(
            'ALMACEN MATERIA PRIMA',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
               
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 400,
                        child: TextFormField(
                          controller: _codigoSbaController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Ingrese Código SBA',
                              prefixIcon: Icon(Icons.search)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _obtenerDatos,
                        child: const Icon(Icons.search, size: 50),
                      ),
                      const SizedBox(width: 190),
                      Container(
                        height: 70,
                        width: 70,
                        child: FloatingActionButton(
                            elevation: 20,
                            backgroundColor: Color.fromARGB(255, 59, 252, 232),
                            child: Icon(
                              Icons.qr_code,
                              size: 50,
                            ),
                            onPressed: () => _scanearCodigo()),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TablaAlmacen(
                          jsonData: jsonData,
                          resultados: jsonData,
                          jsonDataUbi: jsonDataUbi,
                        ),
                       
                        TablaUbicacion(
                          jsonData: jsonData,
                          jsonDataUbi: jsonDataUbi,
                          resultados: [],
                          onInsertarUbicacion: _insertarUbicacion,
                          onEliminarUbicacion: _eliminarUbicacion,
                          onActualizarUbicacion: _actualizarUbicacion,
                        ),
                       
                      ],
                    ),
                  ),
                ),

                

                //MyFooter(),
              ],
            ),
          ],
        ));
  }

  Future<void> _obtenerDatos() async {
    try {
      final codigoSba = _codigoSbaController.text;
      if (codigoSba.isNotEmpty) {
        final url =
            'http://190.107.181.163:81/amq/flutter_ajax.php?search=$codigoSba';
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            jsonData = data is List<dynamic> ? data : [];
          });
        } else {
          setState(() {
            jsonData = [];
          });
          print('Error al consumir la API');
        }
      } else {
        print('Ingrese un código SBA válido');
      }

      // Realizar petición GET a la ruta del API para obtener los datos de ubicación
      final urlUbi =
          'http://190.107.181.163:81/amq/flutter_ajax_ubi.php?search=$codigoSba';
      final responseUbi = await http.get(Uri.parse(urlUbi));
      if (responseUbi.statusCode == 200) {
        final dataUbi = jsonDecode(responseUbi.body);
        setState(() {
          jsonDataUbi = dataUbi is List<dynamic> ? dataUbi : [];
        });
      } else {
        setState(() {
          jsonDataUbi = [];
        });
        print('Error al obtener datos de ubicación');
      }
    } catch (e) {
      setState(() {
        jsonData = [];
        jsonDataUbi = [];
      });
      print('Error: $e');
    }
  }

  Future<void> _scanearCodigo() async {
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancelar', true, ScanMode.QR);
      if (barcodeScanRes != '-1') {
        final url =
            'http://190.107.181.163:81/amq/flutter_ajax.php?search=$barcodeScanRes';
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            jsonData = data is List<dynamic> ? data : [];
          });
        } else {
          setState(() {
            jsonData = [];
          });
          print('Error al obtener datos desde el escaneo QR');
        }

        // Realizar petición GET a la ruta del API para obtener los datos de ubicación
        final urlUbi =
            'http://190.107.181.163:81/amq/flutter_ajax_ubi.php?search=$barcodeScanRes';
        final responseUbi = await http.get(Uri.parse(urlUbi));
        if (responseUbi.statusCode == 200) {
          final dataUbi = jsonDecode(responseUbi.body);
          setState(() {
            jsonDataUbi = dataUbi is List<dynamic> ? dataUbi : [];
          });
        } else {
          setState(() {
            jsonDataUbi = [];
          });
          print('Error al obtener datos de ubicación desde el escaneo QR');
        }
      } else {
        print('Escaneo QR cancelado');
      }
    } on PlatformException catch (e) {
      print('Error al escanear QR: $e');
    }
  }

  Future<void> _insertarUbicacion(String zona, String stand, String col,
      String fila, String cantidad) async {
    try {
      final codigoSba = _codigoSbaController.text;
      if (codigoSba.isNotEmpty) {
        final url =
            'http://192.168.1.46:81/amq/flutter_ajax_add.php?=$codigoSba'; // URL de tu endpoint para insertar datos
        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'Zona': zona,
            'Stand': stand,
            'col': col,
            'fil': fila,
            'Cantidad': cantidad,
          }),
        );

        // Agregar la respuesta del servidor
        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          if (responseBody['success']) {
            setState(() {
              jsonDataUbi.add({
                'Zona': zona,
                'Stand': stand,
                'col': col,
                'fil': fila,
                'Cantidad': cantidad,
              });
            });
            print('Ubicación insertada correctamente');
          } else {
            print('Error al insertar ubicación: ${responseBody['message']}');
          }
        } else {
          print('Error al insertar ubicación: ${response.statusCode}');
        }
      } else {
        print('Ingrese un código SBA válido');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _eliminarUbicacion(String id) async {
    try {
      final inputRecibido = _codigoSbaController.text;

      final url =
          'http://192.168.1.46:81/amq/flutter_ajax_add.php?search=$inputRecibido'; // URL de tu endpoint para eliminar datos
      final response = await http.delete(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': id}),
      );
      if (response.statusCode == 200) {
        // Actualizar la lista localmente después de una eliminación exitosa
        setState(() {
          jsonDataUbi
              .removeWhere((ubicacion) => ubicacion['id'].toString() == id);
        });
      } else {
        print('Error al eliminar ubicación');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _actualizarUbicacion(String id, String zona, String stand,
      String col, String fila, String cantidad) async {
    try {
      final inputRecibido = _codigoSbaController.text;
      final url =
          'http://192.168.1.46:81/amq/flutter_ajax_add.php?=$inputRecibido'; // URL de tu endpoint para actualizar datos
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'Zona': zona,
          'Stand': stand,
          'col': col,
          'fil': fila,
          'Cantidad': cantidad,
        }),
      );
      if (response.statusCode == 200) {
        // Actualizar la lista localmente después de una actualización exitosa
        setState(() {
          final index = jsonDataUbi
              .indexWhere((ubicacion) => ubicacion['id'].toString() == id);
          if (index != -1) {
            jsonDataUbi[index] = {
              'id': id,
              'Zona': zona,
              'Stand': stand,
              'col': col,
              'fil': fila,
              'Cantidad': cantidad,
            };
          }
        });
      } else {
        print('Error al actualizar ubicación');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Map<String, int> _calcularDiferencias() {
    Map<String, int> diferencias = {};

    for (var almacen in jsonData) {
      if (almacen['Name'] != 'ALMACEN DE FALTANTES') {
        String almacenName = almacen['Name'];
        int almacenStock = int.tryParse(almacen['Stock'].toString()) ?? 0;
        int totalUbicacionStock = jsonDataUbi
            .where((ubicacion) => ubicacion['Zona'] == almacenName)
            .fold(
                0,
                (sum, ubicacion) =>
                    sum + (int.tryParse(ubicacion['Cantidad']) ?? 0));

        int diferencia = almacenStock - totalUbicacionStock;
        diferencias[almacenName] = diferencia;
      }
    }

    return diferencias;
  }
}
