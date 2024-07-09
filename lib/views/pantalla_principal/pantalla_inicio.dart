import 'package:flutter/material.dart';
import 'package:sistema_almacenes/views/Layout/layout.dart';
import 'package:sistema_almacenes/views/Ubicaciones/actualizar_ubicaciom.dart';
import 'package:sistema_almacenes/views/index.dart';
import 'package:sistema_almacenes/views/login/login.dart';



class PantallaInicioAmp extends StatefulWidget {
  @override
  State<PantallaInicioAmp> createState() => _PantallaInicioAmpState();
}

class _PantallaInicioAmpState extends State<PantallaInicioAmp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      UserAccountsDrawerHeader(
        accountName: Text("John Doe"),
        accountEmail: Text("johndoe@example.com"),
        currentAccountPicture: CircleAvatar(
          backgroundImage: NetworkImage("https://example.com/profile_picture.jpg"),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://example.com/background_image.jpg"),
            fit: BoxFit.fill,
          ),
        ),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: Text("Home"),
        onTap: () {
  
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text("Settings"),
        onTap: () {
      
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: Icon(Icons.help),
        title: Text("Help"),
        onTap: () {
        
          Navigator.pop(context);
        },
      ),
      ListTile(
        leading: Icon(Icons.info),
        title: Text("About"),
        onTap: () {
       
          showAboutDialog(
            context: context,
            applicationName: "My App",
            applicationVersion: "1.0.0",
            applicationLegalese: "Copyright 2023 My Company",
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.logout),
        title: Text("Log out"),
        onTap: () {
      
          Navigator.pop(context);
        },
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.language),
        title: Text("Language"),
        trailing: DropdownButton(
          value: "en",
          onChanged: (value) {
       
          },
          items: [
            DropdownMenuItem(
              child: Text("English"),
              value: "en",
            ),
            DropdownMenuItem(
              child: Text("Spanish"),
              value: "es",
            ),
            DropdownMenuItem(
              child: Text("French"),
              value: "fr",
            ),
          ],
        ),
      ),
      ListTile(
        leading: Icon(Icons.add),
        title: Text("Theme"),
        trailing: Switch(
          value: true,
          onChanged: (value) {
          
          },
        ),
      ),
    ],
  ),
),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://peruoffset.pe/assets/images/iconos/logo-peruoffset.png'), // URL de la imagen de fondo
                  
                  alignment: Alignment.center, // Centrar la imagen
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

                GridView.count(
                  shrinkWrap: true,
                  primary: true,
                  crossAxisCount:4,
                  children: <Widget>[
                    _buildGridItem(context, "BD-GENERAL", "Inventario", 'https://cdn-icons-png.flaticon.com/512/2271/2271068.png'),
                    _buildGridItem2(context, "BD-GENERAL", "Layout", 'https://cdn-icons-png.flaticon.com/512/1483/1483285.png'),
                    _buildGridItem3(context, "ACTUALIZAR UBI", "Mas Ubicaciones", 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTA0nkCT9ewdzBTTS4ZiH2Y-fxPhVdxgobn5w&s'),
                    _buildGridItemLogin(context, "LOGIN", "Iniciar Sesión", 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7zboBPsPba3Hb0zyRhb0zO77b6_QKcW5gZg&s')
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
          MaterialPageRoute(builder: (context) =>  InsertarUbicacion()),
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

  Widget _buildGridItemLogin(BuildContext context, String title1, String title2, String imageUrl) {
    return GestureDetector(
      onTap: () {
        // Navegar a la nueva vista aquí
       Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  LoginScreen()),
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

