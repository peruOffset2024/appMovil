import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sistema_almacenes/views/Ubicaciones/actualizar_vista.dart';

class ActualizarUbicacion extends StatefulWidget {
   ActualizarUbicacion({super.key});

  @override
  State<ActualizarUbicacion> createState() => _ActualizarUbicacionState();
}

class _ActualizarUbicacionState extends State<ActualizarUbicacion> {
  final TextEditingController _ubicar= TextEditingController();
  List<dynamic> jsonUbi = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cambiar Ubicacion'),
      centerTitle: true,
      backgroundColor: const Color.fromARGB(255, 182, 57, 48),),
     
      body: Column(
        
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(children: [
            SizedBox(height: 100,),
            Container(
              width: 240,
              height: 80,
              child: TextField(
                controller: _ubicar,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                hintText: 'Ingrese codigo SBA',
                prefixIcon: Icon(Icons.search)
                ),
              ),
            ),
            ElevatedButton(onPressed: _actualizarUbi, child: Text('Buscar'))

          ],),
          Expanded(child: SingleChildScrollView(child: Column(
            children: [
              VistaActualizarUbicacion(jsonDataUbi: jsonUbi, resultados: [],),
            ],
          )))
        ]

        

      ),
    );
  }

  Future<void> _actualizarUbi()async{
    try{
      final datosUbi = _ubicar.text;
      if(datosUbi.isNotEmpty){
        final urlUbi = 'http://190.107.181.163:81/amq/flutter_ajax_ubi.php?search=$datosUbi';
        final responseUbicac = await http.get(Uri.parse(urlUbi));
        if(responseUbicac.statusCode == 200){
          final ubiData = jsonDecode(responseUbicac.body);
          setState(() {
            jsonUbi = ubiData is List<dynamic> ? ubiData : [];

          });
        } else{
          setState(() {
            jsonUbi = [];
          });
          print('Error al obtener la ubicacion');
        }
      } else{
        setState(() {
          jsonUbi = [];
        });
        print('Ingrese un codigo valido');
      }

    } catch(e){
      setState(() {
        jsonUbi = [];
      });
      print('Error: $e');
    }

  }
}