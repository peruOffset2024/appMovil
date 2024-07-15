import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TablaUbicacion extends StatefulWidget {
  final TextEditingController codigoSba;
  final List<dynamic> jsonData;
  final List<dynamic> jsonDataUbi;
  final void Function(String zona, String stand, String col, String fila, String cantidad) onInsertarUbicacion;
  final void Function(String id, String zona, String stand, String col, String fila, String cantidad) onActualizarUbicacion;
  final void Function(String id) onEliminarUbicacion;

  TablaUbicacion({
    Key? key,
    required this.jsonData,
    required this.jsonDataUbi,
    required this.onInsertarUbicacion,
    required this.onActualizarUbicacion,
    required this.onEliminarUbicacion,
    required this.codigoSba, required List resultados,
  }) : super(key: key);

  @override
  State<TablaUbicacion> createState() => _TablaUbicacionState();
}

class _TablaUbicacionState extends State<TablaUbicacion> {
  final TextEditingController _ubicacionController = TextEditingController();
  final TextEditingController _zonaController = TextEditingController();
  final TextEditingController _standController = TextEditingController();
  final TextEditingController _colController = TextEditingController();
  final TextEditingController _filController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _imgController = TextEditingController();

  @override
  void dispose() {
    _ubicacionController.dispose();
    _zonaController.dispose();
    _standController.dispose();
    _colController.dispose();
    _filController.dispose();
    _usuarioController.dispose();
    _cantidadController.dispose();
    _imgController.dispose();
    super.dispose();
  }

  void _clearTextControllers() {
    _ubicacionController.clear();
    _zonaController.clear();
    _standController.clear();
    _colController.clear();
    _filController.clear();
    _cantidadController.clear();
    _usuarioController.clear();
    _imgController.clear();
  }

  Future<void> _actualizarData(Map<String, dynamic> ubicacion) async {
    try {
      final url = 'http://190.107.181.163:81/amq/flutter_ajax_edit.php';

      final response = await http.put(Uri.parse(url), body: {
        'id': ubicacion['id'] ?? '',
        'usuario': ubicacion['usuario'] ?? '',
        'Ubicacion': ubicacion['Ubicacion'] ?? '',
        'Zona': ubicacion['Zona'] ?? '',
        'Stand': ubicacion['Stand'] ?? '',
        'col': ubicacion['col'] ?? '',
        'fil': ubicacion['fil'] ?? '',
        'Cantidad': ubicacion['Cantidad'] ?? '',
        'Img': ubicacion['Img'] ?? '',
      });

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        setState(() {
          final index = widget.jsonDataUbi.indexWhere((element) => element['id'] == ubicacion['id']);
          if (index != -1) {
            widget.jsonDataUbi[index] = ubicacion;
            _clearTextControllers();
          }
        });
      } else {
        print('Error al actualizar la ubicación. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> enviarData() async {
    try {
      final sbaCodigoUbi = widget.codigoSba.text;
      final url = 'http://190.107.181.163:81/amq/flutter_ajax_add.php';

      final response = await http.post(Uri.parse(url), body: {
        'search': sbaCodigoUbi,
        'ubicacion': _ubicacionController.text,
        'zona': _zonaController.text,
        'stand': _standController.text,
        'col': _colController.text,
        'fil': _filController.text,
        'cantidad': _cantidadController.text,
        'usuario': _usuarioController.text,
        'img': _imgController.text,
      });

      if (response.statusCode == 200) {
        final newData = {
          'Ubicacion': _ubicacionController.text,
          'Zona': _zonaController.text,
          'Stand': _standController.text,
          'col': _colController.text,
          'fil': _filController.text,
          'Cantidad': _cantidadController.text,
          'usuario': _usuarioController.text,
          'Img': _imgController.text,
        };
        setState(() {
          widget.jsonDataUbi.add(newData);
          _clearTextControllers();
        });
      } else {
        print('Error al enviar datos a la API. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void mostrarFormularioUbicacion({Map<String, dynamic>? mapUbicacion}) {
    if (mapUbicacion != null) {
      _ubicacionController.text = mapUbicacion['Ubicacion'] ?? '';
      _zonaController.text = mapUbicacion['Zona'] ?? '';
      _standController.text = mapUbicacion['Stand'] ?? '';
      _colController.text = mapUbicacion['col'] ?? '';
      _filController.text = mapUbicacion['fil'] ?? '';
      _cantidadController.text = mapUbicacion['Cantidad'] ?? '';
      _usuarioController.text = mapUbicacion['usuario'] ?? '';
      _imgController.text = mapUbicacion['Img'] ?? '';
    } else {
      _clearTextControllers();
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(mapUbicacion == null ? 'Agregar Ubicación' : 'Actualizar Ubicación'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                
                TextField(controller: _ubicacionController, decoration: InputDecoration(labelText: 'Ubicación')),
                TextField(controller: _zonaController, decoration: InputDecoration(labelText: 'Zona')),
                TextField(controller: _standController, decoration: InputDecoration(labelText: 'Stand')),
                TextField(controller: _colController, decoration: InputDecoration(labelText: 'Col')),
                TextField(controller: _filController, decoration: InputDecoration(labelText: 'Fila')),
                TextField(controller: _usuarioController, decoration: InputDecoration(labelText: 'Usuario')),
                TextField(controller: _cantidadController, decoration: InputDecoration(labelText: 'Cantidad')),
                TextField(controller: _imgController, decoration: InputDecoration(labelText: 'Img')),
              
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (mapUbicacion == null) {
                  enviarData();
                } else {
                  final updatedUbicacion = {
                    'id': mapUbicacion['id'],
                    'usuario': _usuarioController.text,
                    'Ubicacion': _ubicacionController.text,
                    'Zona': _zonaController.text,
                    'Stand': _standController.text,
                    'col': _colController.text,
                    'fil': _filController.text,
                    'Cantidad': _cantidadController.text,
                    'Img': _imgController.text,
                  };
                  _actualizarData(updatedUbicacion);
                }
                Navigator.of(context).pop();
              },
              child: Text(mapUbicacion == null ? 'Crear' : 'Actualizar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalCantidadUbicaciones = 0.0;

    for (var data in widget.jsonDataUbi) {
      if (data['Cantidad'] != null && data['Cantidad'] is num) {
        totalCantidadUbicaciones += data['Cantidad'];
      } else if (data['Cantidad'] != null && data['Cantidad'] is String) {
        totalCantidadUbicaciones += double.tryParse(data['Cantidad']) ?? 0.0;
      }
    }

    double totalCantidadAlmacen = 0.0;
    widget.jsonData.where((data) => !['ALMACEN DE FALTANTES', 'ALMACEN DE PRODUCTOS TERMINADO'].contains(data['Name'])).forEach((data) {
      double stockValue = 0.0;
      if (data['Stock'] != null) {
        if (data['Stock'] is num) {
          stockValue = (data['Stock'] as num).toDouble();
        } else if (data['Stock'] is String) {
          stockValue = double.tryParse(data['Stock']) ?? 0.0;
        }
      }
      totalCantidadAlmacen += stockValue;
    });

    double diferencia = totalCantidadAlmacen - totalCantidadUbicaciones;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.jsonData.isNotEmpty) ...[
              Container(
                width: 600,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ubicación',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 100),
                  ],
                ),
              ),
              SizedBox(height: 10)
            ],
            widget.jsonDataUbi.isNotEmpty
                ? Container(
                    width: 700,
                    child: Card(
                      elevation: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: DataTable(
                          columnSpacing: 25.0,
                          horizontalMargin: 20.0,
                          headingRowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.grey[300]!,
                          ),
                          columns: const [
                            DataColumn(
                              label: Text(
                                'UPDATE',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'ZONA',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'STAND',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'COL',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'FILA',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'CANTIDAD',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'ADD',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                          rows: [
                            ...widget.jsonDataUbi.map<DataRow>((data) {
                              return DataRow(
                                cells: [
                                  DataCell(IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      mostrarFormularioUbicacion(mapUbicacion: data);
                                    },
                                  )),
                                  DataCell(Container(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      data['Zona'] ?? 'Sin zona',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  )),
                                  DataCell(Container(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      data['Stand'] ?? 'Sin stand',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  )),
                                  DataCell(Container(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      data['col']?.toString() ?? 'Sin col',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  )),
                                  DataCell(Container(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      data['fil']?.toString() ?? 'Sin fila',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  )),
                                  DataCell(Container(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      data['Cantidad']?.toString() ?? 'Sin cantidad',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  )),
                                  DataCell(IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      mostrarFormularioUbicacion();
                                    },
                                  )),
                                ],
                              );
                            }).toList(),
                            DataRow(
                              cells: [
                                DataCell(Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    '',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                )),
                                DataCell(Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'TOTAL',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.blue,
                                    ),
                                  ),
                                )),
                                DataCell(Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    '',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                )),
                                DataCell(Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    '',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                )),
                                DataCell(Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    '',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                )),
                                DataCell(Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    totalCantidadUbicaciones.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.blue,
                                    ),
                                  ),
                                )),
                                DataCell(Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    '',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const Center(child: Text('')), // No hay ubicaciones disponibles+++++++++
            SizedBox(height: 20),
            if (widget.jsonData.isNotEmpty) ...[
              Text(
                'Diferencias',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                width: 700,
                child: Card(
                  elevation: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: DataTable(
                      columnSpacing: 190.0,
                      horizontalMargin: 20.0,
                      headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.grey[300]!,
                      ),
                      columns: const [
                        DataColumn(
                          label: Text(
                            'CONCEPTO',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'TOTAL',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                      rows: [
                        DataRow(
                          cells: [
                            DataCell(Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Total Almacen',
                                style: TextStyle(fontSize: 14),
                              ),
                            )),
                            DataCell(Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                totalCantidadAlmacen.toString(),
                                style: TextStyle(fontSize: 14),
                              ),
                            )),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Total Ubicaciones',
                                style: TextStyle(fontSize: 14),
                              ),
                            )),
                            DataCell(Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                totalCantidadUbicaciones.toString(),
                                style: TextStyle(fontSize: 14),
                              ),
                            )),
                          ],
                        ),
                        DataRow(
                          cells: [
                            DataCell(Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Diferencia',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.red,
                                ),
                              ),
                            )),
                            DataCell(Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                diferencia.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.red,
                                ),
                              ),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
