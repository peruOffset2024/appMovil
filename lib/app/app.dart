import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sistema_almacenes/views/login/logeo.dart';
import 'package:sistema_almacenes/views/login/usuario.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => usuarioProvider())
      ],
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        home: LoginVista(),
      ),
    );
  }
}