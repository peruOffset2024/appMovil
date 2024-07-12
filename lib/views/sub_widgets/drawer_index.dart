
import 'package:flutter/material.dart';

class DrawerIndex extends StatelessWidget {
  const DrawerIndex({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
    UserAccountsDrawerHeader(
      accountName: Text("John Doe"),
      accountEmail: Text("johndoe@example.com"),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage("https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcQn01qluqWvOFoKI8IjcMJrFnQO__NhykedGs4Y6V4ShU7MgPtj"),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://peruoffset.pe/assets/images/iconos/logo-peruoffset.png"),
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
    );
  }
}
