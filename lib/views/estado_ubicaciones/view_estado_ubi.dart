import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VistaEstadoUbicacion extends StatefulWidget {
  const VistaEstadoUbicacion({super.key});

  @override
  State<VistaEstadoUbicacion> createState() => _VistaEstadoUbicacionState();
}

class _VistaEstadoUbicacionState extends State<VistaEstadoUbicacion> {
  List<dynamic> ubicaciones = [];

  @override
  void initState() {
    super.initState();
    fetchUbicaciones();
  }

  Future<void> fetchUbicaciones() async {
    final response = await http.get(Uri.parse('http://190.107.181.163:81/amq/flutter_ajax_ubi.php?search=757'));
    if (response.statusCode == 200) {
      setState(() {
        ubicaciones = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://c4.wallpaperflare.com/wallpaper/504/277/264/avatar-anime-avatar-the-legend-of-korra-wallpaper-preview.jpg'),
                    fit: BoxFit.cover,
                    alignment: Alignment.center)),
            child: ubicaciones.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.count(
                            shrinkWrap: true,
                            primary: false,
                            crossAxisCount: 2, // Ajustado para mejorar la visualización
                            childAspectRatio: 0.75, // Ajustado para mejorar la proporción de los elementos
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                            children: _buildGridItems(),
                          ),
                        ),
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildGridItems() {
    List<Widget> items = [];
    for (int i = 0; i < ubicaciones.length; i += 3) {
      items.add(
        _rack4col123filaA(
          ubicaciones[i],
          i + 1 < ubicaciones.length ? ubicaciones[i + 1] : null,
          i + 2 < ubicaciones.length ? ubicaciones[i + 2] : null,
        ),
      );
    }
    return items;
  }
}

Widget _rack4col123filaA(Map<String, dynamic> ubic1, Map<String, dynamic>? ubic2, Map<String, dynamic>? ubic3) {
  return GestureDetector(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Text('Zona: ${ubic1['Zona']}'),
              Text('Stand: ${ubic1['Stand']}'),
              Text('Cantidad: ${ubic1['Cantidad']}'),
              Text('Descripción: ${ubic1['Descripcion']}'),
              if (ubic2 != null) ...[
                const Divider(),
                
                Text('Zona: ${ubic2['Zona']}'),
                Text('Stand: ${ubic2['Stand']}'),
                Text('Cantidad: ${ubic2['Cantidad']}'),
                Text('Descripción: ${ubic2['Descripcion']}'),
              ],
              if (ubic3 != null) ...[
                const Divider(),
               
                Text('Zona: ${ubic3['Zona']}'),
                Text('Stand: ${ubic3['Stand']}'),
                Text('Cantidad: ${ubic3['Cantidad']}'),
                Text('Descripción: ${ubic3['Descripcion']}'),
              ],
            ],
          ),
        ),
      ),
    ),
  );
}
