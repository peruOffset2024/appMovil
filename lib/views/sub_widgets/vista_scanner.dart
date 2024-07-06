import 'package:flutter/material.dart';

class ResultadosQr extends StatelessWidget {
  final List<dynamic> resultados;

  const ResultadosQr({Key? key, required this.resultados}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultados del Escaneo'),
      ),
      body: resultados.isNotEmpty
          ? ListView.builder(
              itemCount: resultados.length,
              itemBuilder: (context, index) {
                final resultado = resultados[index];
                return ListTile(
                  title: Text(resultado['descripcion'] ?? 'Sin descripción'),
                  subtitle: Text('Código: ${resultado['codigo']}'),
                );
              },
            )
          : Center(
              child: Text('No se encontraron resultados.'),
            ),
    );
  }
}
