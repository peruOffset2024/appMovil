/*ElevatedButton(
                      onPressed: () => _mostrarDialogoAgregar(context),
                      child: const Text('Agregar Ubicación'),
                    ),
                    
                    
                    
            void _mostrarDialogoAgregar(BuildContext context) {
    final TextEditingController zonaController = TextEditingController();
    final TextEditingController standController = TextEditingController();
    final TextEditingController colController = TextEditingController();
    final TextEditingController filaController = TextEditingController();
    final TextEditingController cantidadController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Agregar Ubicación'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: zonaController,
                  decoration: InputDecoration(labelText: 'Zona'),
                ),
                TextFormField(
                  controller: standController,
                  decoration: InputDecoration(labelText: 'Stand'),
                ),
                TextFormField(
                  controller: colController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Columna'),
                ),
                TextFormField(
                  controller: filaController,
                  decoration: InputDecoration(labelText: 'Fila'),
                ),
                TextFormField(
                  controller: cantidadController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Cantidad'),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                onInsertarUbicacion(
                  zonaController.text,
                  standController.text,
                  colController.text,
                  filaController.text,
                  cantidadController.text,
                );
                Navigator.of(context).pop();
              },
              child: Text('Guardar'),
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

  void _mostrarDialogoEliminar(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Eliminar Ubicación'),
          content: Text('¿Desea eliminar esta ubicación?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                onEliminarUbicacion(id);
                Navigator.of(context).pop();
              },
              child: Text('Eliminar'),
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

  void _mostrarDialogoActualizar(BuildContext context, String id, String zona, String stand, String col, String fila, String cantidad) {
    final TextEditingController zonaController = TextEditingController(text: zona);
    final TextEditingController standController = TextEditingController(text: stand);
    final TextEditingController colController = TextEditingController(text: col);
    final TextEditingController filaController = TextEditingController(text: fila);
    final TextEditingController cantidadController = TextEditingController(text: cantidad);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Actualizar Ubicación'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: zonaController,
                  decoration: InputDecoration(labelText: 'Zona'),
                ),
                TextFormField(
                  controller: standController,
                  decoration: InputDecoration(labelText: 'Stand'),
                ),
                TextFormField(
                  controller: colController,
                  decoration: InputDecoration(labelText: 'Columna'),
                ),
                TextFormField(
                  controller: filaController,
                  decoration: InputDecoration(labelText: 'Fila'),
                ),
                TextFormField(
                  controller: cantidadController,
                  decoration: InputDecoration(labelText: 'Cantidad'),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                onActualizarUbicacion(
                  id,
                  zonaController.text,
                  standController.text,
                  colController.text,
                  filaController.text,
                  cantidadController.text,
                );
                Navigator.of(context).pop();
              },
              child: Text('Guardar'),
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
  } */