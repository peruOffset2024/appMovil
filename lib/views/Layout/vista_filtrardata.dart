import 'package:flutter/material.dart';

class VistaPrueba extends StatelessWidget {
  const VistaPrueba({super.key, required this.jsonObtenidoApi});
  final List<dynamic> jsonObtenidoApi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: jsonObtenidoApi.isNotEmpty
          ? Container(
              child: ListView.builder(
              itemCount: jsonObtenidoApi.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(jsonObtenidoApi[index]['Itemdescripcion']),
                  subtitle: Text(jsonObtenidoApi[index]['Stock']),
                );
              },
            ))
          : Center(
              child: Text('No hay informacion del codigo solicitado'),
            ),
    );
  }
}