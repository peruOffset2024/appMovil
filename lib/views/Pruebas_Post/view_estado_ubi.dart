import 'package:flutter/material.dart';


class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();

  final _sbaCodigoUbiController = TextEditingController();
  final _ubicacionController = TextEditingController();
  final _zonaController = TextEditingController();
  final _standController = TextEditingController();
  final _colController = TextEditingController();
  final _filController = TextEditingController();
  final _cantidadController = TextEditingController();
  final _usuarioController = TextEditingController();
  final _imgController = TextEditingController();

  List<Map<String, dynamic>> jsonUbic = [];

  void _addNewUbicacion() {
    final newUbicacion = {
      'search': '',
      'ubicacion': '',
      'zona': '',
      'stand': '',
      'col': '',
      'fil': '',
      'cantidad': '',
      'usuario': '',
      'img': '',
    };

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Agregar nueva ubicación'),
          content: Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'SBA Código UBI'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese un valor';
                    }
                    return null;
                  },
                  onSaved: (value) => newUbicacion['search'] = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Ubicación'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese un valor';
                    }
                    return null;
                  },
                  onSaved: (value) => newUbicacion['ubicacion'] = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Zona'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese un valor';
                    }
                    return null;
                  },
                  onSaved: (value) => newUbicacion['zona'] = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Stand'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese un valor';
                    }
                    return null;
                  },
                  onSaved: (value) => newUbicacion['stand'] = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Columna'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese un valor';
                    }
                    return null;
                  },
                  onSaved: (value) => newUbicacion['col'] = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Fila'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese un valor';
                    }
                    return null;
                  },
                  onSaved: (value) => newUbicacion['fil'] = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Cantidad'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese un valor';
                    }
                    return null;
                  },
                  onSaved: (value) => newUbicacion['cantidad'] = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Usuario'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese un valor';
                    }
                    return null;
                  },
                  onSaved: (value) => newUbicacion['usuario'] = value!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Imagen'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor ingrese un valor';
                    }
                    return null;
                  },
                  onSaved: (value) => newUbicacion['img'] = value!,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Agregar'),
              onPressed: () {
                setState(() {
                  jsonUbic.add(newUbicacion);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _sbaCodigoUbiController,
            decoration: InputDecoration(labelText: 'SBA Código UBI'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingrese un valor';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _ubicacionController,
            decoration: InputDecoration(labelText: 'Ubicación'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingrese un valor';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _zonaController,
            decoration: InputDecoration(labelText: 'Zona'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingrese un valor';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _standController,
            decoration: InputDecoration(labelText: 'Stand'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingrese un valor';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _colController,
            decoration: InputDecoration(labelText: 'Columna'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingrese un valor';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _filController,
            decoration: InputDecoration(labelText: 'Fila'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingrese un valor';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _cantidadController,
            decoration: InputDecoration(labelText: 'Cantidad'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingrese un valor';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _usuarioController,
            decoration: InputDecoration(labelText: 'Usuario'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingrese un valor';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _imgController,
            decoration: InputDecoration(labelText: 'Imagen'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Por favor ingrese un valor';
              }
              return null;
            },
          ),
          ElevatedButton(
            child: Text('Agregar nueva ubicación'),
            onPressed: _addNewUbicacion,
          ),
          SizedBox(height: 20),
          Text('Ubicaciones agregadas:'),
          ListView.builder(
            shrinkWrap: true,
            itemCount: jsonUbic.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(jsonUbic[index]['ubicacion']),
                subtitle: Text('Zona: ${jsonUbic[index]['zona']}'),
              );
            },
          ),
        ],
      ),
    );
  }
}