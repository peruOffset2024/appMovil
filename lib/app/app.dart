import 'package:flutter/material.dart';
import 'package:sistema_almacenes/views/pantalla_principal/pantalla_inicio.dart';






class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.brown),
      home: Scaffold(
      
        body: PantallaInicioAmp(),
      ),
    );
  }
}