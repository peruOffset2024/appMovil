/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:sistema_de_almacenes/Pruebas/vista_prueba.dart';

class IndexPag extends StatefulWidget {
  const IndexPag({Key? key}) : super(key: key);

  @override
  State<IndexPag> createState() => _IndexPagState();
}

class _IndexPagState extends State<IndexPag> {
  TextEditingController _codigoSbaController = TextEditingController();
  List<dynamic> jsonData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _codigoSbaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Ingrese Código SBA',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _obtenerDatos,
                  child: const Icon(Icons.search, size: 25),
                ),
                IconButton(
                  icon: Icon(Icons.qr_code, size: 50,),
                  onPressed: _scanearCodigo,
                ),
              ],
            ),
          ),
          Expanded(
            child: DataInput(jsonData: jsonData),
          ),
        ],
      ),
    );
  }

  Future<void> _obtenerDatos() async {
    try {
      final codigoSba = _codigoSbaController.text;
      if (codigoSba.isNotEmpty) {
        final url = 'http://190.107.181.163:81/amq/flutter_ajax.php?search=$codigoSba';
        final headers = {'Content-Type': 'application/json'};
        final response = await http.get(Uri.parse(url), headers: headers);
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
    } catch (e) {
      setState(() {
        jsonData = [];
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
      } else {
        print('Escaneo QR cancelado');
      }
    } on PlatformException catch (e) {
      print('Error al escanear QR: $e');
    }
  }
}*/