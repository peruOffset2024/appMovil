import 'package:flutter/material.dart';

class TablaUbicacion extends StatelessWidget {
  final List<dynamic> jsonData;
  final List<dynamic> jsonDataUbi;
  final void Function(String zona, String stand, String col, String fila, String cantidad) onInsertarUbicacion;
  final void Function(String id) onEliminarUbicacion;
  final void Function(String id, String zona, String stand, String col, String fila, String cantidad) onActualizarUbicacion;

  const TablaUbicacion({
    Key? key,
    required this.jsonData,
    required this.jsonDataUbi,
    required List<dynamic> resultados,
    required this.onInsertarUbicacion,
    required this.onEliminarUbicacion,
    required this.onActualizarUbicacion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calcula el total de cantidades de todas las ubicaciones
    double totalCantidadUbicaciones = 0.0;

    for (var data in jsonDataUbi) {
      if (data['Cantidad'] != null && data['Cantidad'] is num) {
        totalCantidadUbicaciones += data['Cantidad'];
      } else if (data['Cantidad'] != null && data['Cantidad'] is String) {
        totalCantidadUbicaciones += double.tryParse(data['Cantidad']) ?? 0.0;
      }
    }

    // Calcula el total de cantidades de los almacenes específicos
    double totalCantidadAlmacen = 0.0;
   
    jsonData.where((data) => !['ALMACEN DE FALTANTES', 'ALMACEN DE PRODUCTOS TERMINADO'].contains(data['Name'])).forEach((data) {
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
            if (jsonData.isNotEmpty) ...[
              Container(
                width: 600,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ubicación ',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 100,),
                  ],
                ),
              ),
              SizedBox(height: 10,)
            ],
            jsonDataUbi.isNotEmpty
                ? 
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
                        headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.grey[300]!,
                        ),
                        columns: const [
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
                          
                        ],
                        rows: [
                          ...jsonDataUbi.map<DataRow>((data) {
                            return DataRow(
                              cells: [
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
                                
                              ],
                            );
                              
                          }).toList(),
                            
                          DataRow(
                            cells: [
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
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                : const Center(child: Text('')), // no hay ubicaciones disponibles
            
            SizedBox(height: 20),
            if (jsonData.isNotEmpty) ...[
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
                              )),
                        )],
                        ),
                      ],
                      columnSpacing: 20.0,
                      horizontalMargin: 10.0,
                      headingTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      dataTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey[400]!, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
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
