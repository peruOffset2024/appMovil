import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:sistema_almacenes/views/sub_widgets/drawer_index.dart';
import 'package:sistema_almacenes/views/Ubicaciones/actualizar_ubicaciom.dart';
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

  double _left = 0;
  double _top = 0;

  @override
  void initState() {
    super.initState();
    // Initialize _left and _top based on the screen size
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      setState(() {
        _left = screenWidth - 56; // Adjust this value to fine-tune the position
        _top = (screenHeight / 2) - 28; // Center vertically
      });
    });
  }

  void _navigateToNewScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InsertarUbicacion()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerIndex(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF6CA8F1),
        title: Text(
          'Gestion de inventario',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                            prefixIcon: const Icon(Icons.search)),
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
                          child: const Icon(
                            Icons.qr_code,
                            size: 50,
                          ),
                          onPressed: () => _scanearCodigo()),
                    ),
                  ],
                ),
              ),
              if (_left != 0 && _top != 0) Positioned(
            left: _left,
            top: _top,
            child: Draggable(
              feedback: _buildChatHead(),
              child: _buildChatHead(),
              childWhenDragging: Container(),
              onDragEnd: (details) {
                setState(() {
                  double newLeft = details.offset.dx;
                  double newTop = details.offset.dy;
          
                  // Ensure the button stays within the screen bounds
                  if (newLeft < 0) newLeft = 0;
                  if (newTop < 0) newTop = 0;
                  if (newLeft > MediaQuery.of(context).size.width - 56) {
                    newLeft = MediaQuery.of(context).size.width - 56;
                  }
                  if (newTop > MediaQuery.of(context).size.height - 56) {
                    newTop = MediaQuery.of(context).size.height - 56;
                  }
          
                  _left = newLeft;
                  _top = newTop;
                });
              },
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
                        onActualizarUbicacion: _actualizarUbicacion,
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
          
        ],
      ),
    );
  }

  Widget _buildChatHead() {
    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        onTap: _navigateToNewScreen,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
            image: DecorationImage(
              image: NetworkImage(
                  'https://st4.depositphotos.com/18664664/23958/v/450/depositphotos_239582718-stock-illustration-store-icon-trendy-store-logo.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
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
          "#ff6666", "Cancelar", false, ScanMode.BARCODE);
      setState(() {
        _codigoSbaController.text = barcodeScanRes;
      });
    } on PlatformException {
      print('Failed to get platform version.');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _insertarUbicacion(String zona, String stand, String col,
      String fila, String cantidad) async {
    try {
      final inputRecibido = _codigoSbaController.text;
      if (inputRecibido.isNotEmpty) {
        final url =
            'http://192.168.1.46:81/amq/flutter_ajax_add.php?=$inputRecibido'; // URL de tu endpoint para insertar datos
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
