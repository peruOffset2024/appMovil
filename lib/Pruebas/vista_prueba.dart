import 'package:flutter/material.dart';

class DataInput extends StatelessWidget {
  final List<dynamic> jsonData;
  const DataInput({Key? key, required this.jsonData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (jsonData.isNotEmpty) ...[
            Container(
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
              ? Card(
                  elevation: 5,
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
                      rows: jsonData.map<DataRow>((data) {
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
                )
              : const Center(child: Text('Codigo SBA no existe')),
        ],
      ),
    );
  }
}