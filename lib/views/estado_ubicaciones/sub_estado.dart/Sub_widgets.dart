/*import 'package:flutter/material.dart';

class TablaUbicacion extends StatefulWidget {
  final List<dynamic> jsonData;
  final List<dynamic> jsonDataUbi;

  const TablaUbicacion({Key? key, required this.jsonData, required this.jsonDataUbi, required List resultados }) : super(key: key);

  @override
  _TablaUbicacionState createState() => _TablaUbicacionState();
}

class _TablaUbicacionState extends State<TablaUbicacion> {
  List<dynamic> _jsonDataUbi = [];

  @override
  void initState() {
    super.initState();
    _jsonDataUbi = widget.jsonDataUbi;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    'Ubicación ',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 300,),
                  GestureDetector(
                    onTap: () {
                      _editarUbicacion(context);
                    },
                    child: ElevatedButton(
                      onPressed: () => _editarUbicacion(context), 
                      child: const Text('Editar Ubicacion'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,)
          ],
          _jsonDataUbi.isNotEmpty
              ? 
              Container(
                width: 600,
                child: Card(
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
                      rows: _jsonDataUbi.map<DataRow>((data) {
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
                        border:
                            Border.all(color: Colors.grey[400]!, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              )
              : const Center(child: Text('No hay datos de ubicación')),
        ],
      ),
    );
  }

  void _editarUbicacion(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      final TextEditingController zonaController = TextEditingController();
      final TextEditingController standController = TextEditingController();
      final TextEditingController colController = TextEditingController();
      final TextEditingController filaController = TextEditingController();
      final TextEditingController cantidadController = TextEditingController();

      zonaController.text = _jsonDataUbi[0]['Zona'];
      standController.text = _jsonDataUbi[0]['Stand'];
      colController.text = _jsonDataUbi[0]['col'];
      filaController.text = _jsonDataUbi[0]['fil'];
      cantidadController.text = _jsonDataUbi[0]['Cantidad'];

      return AlertDialog(
        title: Text('Editar Ubicación'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: zonaController,
              decoration: InputDecoration(
                labelText: 'Zona',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: standController,
              decoration: InputDecoration(
                labelText: 'Stand',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: colController,
              decoration: InputDecoration(
                labelText: 'Columna',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: filaController,
              decoration: InputDecoration(
                labelText: 'Fila',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: cantidadController,
              decoration: InputDecoration(
                labelText: 'Cantidad',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              _jsonDataUbi[0]['Zona'] = zonaController.text;
              _jsonDataUbi[0]['Stand'] = standController.text;
              _jsonDataUbi[0]['col'] = colController.text;
              _jsonDataUbi[0]['fil'] = filaController.text;
              _jsonDataUbi[0]['Cantidad'] = cantidadController.text;

              setState(() {}); // Notificar al widget que los datos han cambiado

              Navigator.of(context).pop();
            },
            child: Text('Guardar'),
          ),
        ],
      );
    },
  );
}}
*/