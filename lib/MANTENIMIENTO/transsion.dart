// formulario_ubicacion_page.dart
import 'package:flutter/material.dart';

class FormularioUbicacionPage extends StatefulWidget {
  final TextEditingController ubicacionController;
  final TextEditingController zonaController;
  final TextEditingController standController;
  final TextEditingController colController;
  final TextEditingController filController;
  final TextEditingController cantidadController;
  final TextEditingController usuarioController;
  final TextEditingController imgController;
  final Map<String, dynamic> mapUbicacion;

  FormularioUbicacionPage({
    required this.ubicacionController,
    required this.zonaController,
    required this.standController,
    required this.colController,
    required this.filController,
    required this.cantidadController,
    required this.usuarioController,
    required this.imgController,
    required this.mapUbicacion,
  });

  @override
  _FormularioUbicacionPageState createState() => _FormularioUbicacionPageState();
}

class _FormularioUbicacionPageState extends State<FormularioUbicacionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Ubicación'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: widget.ubicacionController,
                decoration: InputDecoration(labelText: 'Ubicación'),
              ),
              TextFormField(
                controller: widget.zonaController,
                decoration: InputDecoration(labelText: 'Zona'),
              ),
              // ...
            ],
          ),
        ),
      ),
    );
  }
}