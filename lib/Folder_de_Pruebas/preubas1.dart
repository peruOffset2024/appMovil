import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'package:sistema_almacenes/Folder_de_Pruebas/signature_provider.dart';

class SignatureScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final signatureProvider = Provider.of<SignatureProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Signature(
                controller: signatureProvider.controller,
                height:1000,
                width: 750,
                backgroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            
            ElevatedButton(
              child: Text('Borrar'),
              onPressed: () {
                signatureProvider.clearSignature();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveSignature(SignatureController controller) async {
    if (controller.isNotEmpty) {
      final signature = await controller.toPngBytes();
      if (signature != null) {
        // Aquí puedes guardar 'signature' en una base de datos, enviarlo a un servidor, etc.
        print('Guardar firma');
      }
    }
  }
}

class AnotherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Otra pantalla'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Regresar'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}