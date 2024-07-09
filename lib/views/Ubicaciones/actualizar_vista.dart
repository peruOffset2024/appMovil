import 'package:flutter/material.dart';

class InsertarUbicacion2 extends StatelessWidget {
  final List<dynamic> jsonDataUbi;

  const InsertarUbicacion2({Key? key, required this.jsonDataUbi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            jsonDataUbi.isNotEmpty
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
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
                      rows: jsonDataUbi.map<DataRow>((data) {
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
                                data['col'] ?? 'Sin columna',
                                style: TextStyle(fontSize: 14),
                              ),
                            )),
                            DataCell(Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                data['fil'] ?? 'Sin fila',
                                style: TextStyle(fontSize: 14),
                              ),
                            )),
                            DataCell(Container(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                data['Cantidad'] ?? 'Sin cantidad',
                                style: TextStyle(fontSize: 14),
                              ),
                            )),
                          ],
                        );
                      }).toList(),
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
                        border: Border.all(color: Colors.grey[400]!, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                : const Center(child: Text('No hay datos de ubicación')),
          ],
        ),
      ),
    );
  }
}