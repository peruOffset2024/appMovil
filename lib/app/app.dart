import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_almacenes/Folder_de_Pruebas/signature_provider.dart';
import 'package:sistema_almacenes/views/login/logeo.dart';
import 'package:sistema_almacenes/views/login/usuario.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => usuarioProvider()),
        ChangeNotifierProvider(create: (_)=> SignatureProvider())
      ],
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        home: LoginVista(),
      ),
    );
  }
}