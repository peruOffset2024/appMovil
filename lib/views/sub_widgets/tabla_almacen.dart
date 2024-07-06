import 'package:flutter/material.dart';

class TablaAlmacen extends StatelessWidget {
  final List<dynamic> jsonData;
  const TablaAlmacen(
      {Key? key,
      required this.jsonData,
      required List resultados,
      required List jsonDataUbi});

  @override
  Widget build(BuildContext context) {
    // Lista de almacenes que deben considerarse para la suma
    const almacenesConsiderados = [
      'ALMACEN DE RESERVA',
      'ALMACEN HUACHIPA ',
      'ALMACEN CUARENTENA',
      'ALMACEN DE REPUESTOS (2018)'
    ];

    // Calcula el total de cantidades de los almacenes específicos
    double totalCantidad = 0.0;

    jsonData
        .where((data) => !['ALMACEN DE FALTANTES', ''].contains(data['Name']))
        .forEach((data) {
      double stockValue = 0.0;
      if (data['Stock'] != null) {
        if (data['Stock'] is num) {
          stockValue = (data['Stock'] as num).toDouble();
        } else if (data['Stock'] is String) {
          stockValue = double.tryParse(data['Stock']) ?? 0.0;
        }
      }
      totalCantidad += stockValue;
    });

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (jsonData.isNotEmpty) ...[
              Container(
                width: 600,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Almacenes ',
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 100,),
          
                  ],
                ),
              ),
              SizedBox(height: 10,)
            ],
          if (jsonData.isNotEmpty) ...[
            Container(
              width: 700,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SBA: ${jsonData.first['ItemCode'] ?? 'N/A'}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    jsonData.first['itemdescripcion'] ??
                        'Descripción no disponible',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
          jsonData.isNotEmpty
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
                        headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.grey[300]!,
                        ),
                        columns: const [
                          DataColumn(
                            label: Text(
                              'ALMACÉN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'STOCK',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                        rows: [
                          //////
                          ...jsonData
                              .where((data) =>
                                  data['Name'] != 'ALMACEN DE FALTANTES')
                              .map<DataRow>((data) {
                            return DataRow(
                              cells: [
                                DataCell(Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    data['Name'] ?? 'Sin almacén',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                )),
                                DataCell(Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    data['Stock']?.toString() ?? 'Sin stock',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                )),
                              ],
                            );
                          }).toList(),
                          if (jsonData.any((data) =>
                              almacenesConsiderados.contains(data['Name'])))
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
                                    totalCantidad.toString(),
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
                )
              : const Center(child: Text('No existe el codigo SBA')), //texto Codigo SBA no existe
        ],
      ),
    );
  }
}
