import 'package:flutter/material.dart';
import 'package:sistema_almacenes/layout/layout.dart';
import 'package:sistema_almacenes/views/index.dart';
import 'package:sistema_almacenes/views/login/logeo.dart';

class NewPagIndex extends StatefulWidget {
  const NewPagIndex({super.key});

  @override
  State<NewPagIndex> createState() => _NewPagIndexState();
}

class _NewPagIndexState extends State<NewPagIndex> {
  int myIndice = 0;
  List<Widget> rutasPag = [IndexPag(), LayoutAmp(), LoginVista()];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: rutasPag[myIndice],
        bottomNavigationBar: Container(
          height: 80, // Altura personalizada
          padding: EdgeInsets.only(bottom: 2),
          child: BottomNavigationBar(
              elevation: 50,
              backgroundColor: Color.fromARGB(255, 173, 192, 197),
              //type: BottomNavigationBarType.shifting,
              onTap: (index) {
                setState(() {
                  myIndice = index;
                });
              },
              currentIndex: myIndice,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(size: 20, color: Colors.black, Icons.home),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(size: 20, color: Colors.black, Icons.book),
                    label: 'Book'),
                BottomNavigationBarItem(
                    icon:
                        Icon(size: 20, color: Colors.black, Icons.exit_to_app),
                    label: 'Salir')
              ]),
        ),
      ),
    );
  }
}
