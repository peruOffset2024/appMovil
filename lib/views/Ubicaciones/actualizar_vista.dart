import 'package:flutter/material.dart';

class VistaActualizarUbicacion extends StatelessWidget {

  final List<dynamic> jsonDataUbi;

  const VistaActualizarUbicacion({
    Key? key,

    required this.jsonDataUbi,
    required List<dynamic> resultados,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
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
                             
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                : const Center(child: Text('')), // no hay ubicaciones disponibles
          ],
        ),
      ),
    );
  }

  
}
