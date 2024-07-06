/*import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sistema_almacenes/views/sub_widgets/vista_scanner.dart';


class BodyApp extends StatefulWidget {
  const BodyApp({
    super.key,
  });
  @override
  State<BodyApp> createState() => _BodyAppState();
}
class _BodyAppState extends State<BodyApp> {

  // ignore: prefer_final_fields
  TextEditingController _codigoSbaController = TextEditingController();
  List<dynamic> jsonData = [];
 

  @override
  Widget build(BuildContext context) {  
    
    return Container(
            height: 56, 
            decoration: const BoxDecoration(
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
               // ignore: sized_box_for_whitespace
               Container(
                  width: 180,
                  child: TextFormField(
                    
                    controller: _codigoSbaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Ingrese Codigo SBA'),
                  ),
                ),
                
                 ElevatedButton(
              onPressed: () => _obtenerDatos(),
              child: const Icon(
                Icons.search,
                size: 25,
              )),
            
              const SizedBox(width: 50,),
              FloatingActionButton(
                  backgroundColor: Colors.cyanAccent.shade100,
                  onPressed: () => _scanearCodigo(),
                  child: const Icon(Icons.qr_code, size : 50))
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
  





  Future<void> _scanearCodigo() async{
    String barcodeScanRes;
    try{
      // ignore: unused_local_variable
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          'ff6666', 'Cancelar', true, ScanMode.QR);
    } on PlatformException{
      barcodeScanRes = 'No se pudo obtener la versión de la plataforma.';
      
      if (barcodeScanRes != '-1'){
        const apiurl = 'http://190.107.181.163:81/amq/flutter_ajax.php?search=26992';
        final response = await http.get(Uri.parse(apiurl));

        if(response.statusCode == 200){
          final jsonData = jsonDecode(response.body);
          if(jsonData is List){
            // ignore: use_build_context_synchronously
            Navigator.push(context, MaterialPageRoute(builder: (context) => ResultadosQr(resultados: jsonData,)));
          }

        } else {
          // ignore: use_build_context_synchronously
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ResultadosQr(resultados: [],)));
        }

      } else {
        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const ResultadosQr(resultados: [],)));
      }
    }

    

  }

  

}*/