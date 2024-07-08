import 'package:flutter/material.dart';
import 'package:sistema_almacenes/views/Layout/layout.dart';
import 'package:sistema_almacenes/views/Ubicaciones/actualizar_ubicaciom.dart';
import 'package:sistema_almacenes/views/index.dart';



class PantallaInicioAmp extends StatefulWidget {
  @override
  State<PantallaInicioAmp> createState() => _PantallaInicioAmpState();
}

class _PantallaInicioAmpState extends State<PantallaInicioAmp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://www.algevasa.com/wp-content/uploads/2020/02/sistemas-de-almacenamiento-para-la-gestion-de-almacenes.jpg'), // URL de la imagen de fondo
                  fit: BoxFit.cover,
                  alignment: Alignment.center, // Centrar la imagen
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                GridView.count(
                  shrinkWrap: true,
                  primary: true,
                  crossAxisCount: 3,
                  children: <Widget>[
                    _buildGridItem(context, "BD-GENERAL", "Inventario", 'https://cdn-icons-png.flaticon.com/512/2271/2271068.png'),
                    _buildGridItem2(context, "BD-GENERAL", "Layout", 'https://cdn-icons-png.flaticon.com/512/1483/1483285.png'),
                    _buildGridItem3(context, "BD-GENERAL", "Layout", 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTA0nkCT9ewdzBTTS4ZiH2Y-fxPhVdxgobn5w&s')
                  ],
                ),
               
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, String title1, String title2, String imageUrl) {
    return GestureDetector(
      onTap: () {
        // Navegar a la nueva vista aquí
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const IndexPag()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Separador entre los elementos
        child: Card(
          elevation: 3,
          margin: EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50), // Bordes circulares
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                imageUrl, // Imagen de ejemplo
                width: 50,
                height: 50,
              ),
              SizedBox(height: 10),
              Text(
                title1,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                title2,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem2(BuildContext context, String title1, String title2, String imageUrl) {
    return GestureDetector(
      onTap: () {
        // Navegar a la nueva vista aquí
       Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LayoutAmp()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Separador entre los elementos
        child: Card(
          elevation: 3,
          margin: EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50), // Bordes circulares
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                imageUrl, // Imagen de ejemplo
                width: 50,
                height: 50,
              ),
              SizedBox(height: 10),
              Text(
                title1,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                title2,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridItem3(BuildContext context, String title1, String title2, String imageUrl) {
    return GestureDetector(
      onTap: () {
        // Navegar a la nueva vista aquí
       Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  ActualizarUbicacion()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Separador entre los elementos
        child: Card(
          elevation: 3,
          margin: EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50), // Bordes circulares
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                imageUrl, // Imagen de ejemplo
                width: 50,
                height: 50,
              ),
              SizedBox(height: 10),
              Text(
                title1,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                title2,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
}

