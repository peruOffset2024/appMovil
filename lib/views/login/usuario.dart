import 'package:flutter/material.dart';
import 'package:sistema_almacenes/views/login/class_usuario.dart';
import 'package:sistema_almacenes/views/login/constants.dart';
import 'package:http/http.dart' as http;

final urlApi = url;
class usuarioProvider with ChangeNotifier{
  List<Usuario> usuarios = [];

  getUsuarios() async {
    final url1 = Uri.http(urlApi,'amq/flutter_ajax_ubi.php?search=8');
    final resp = await http.get(url1, headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
      "Content-type" : "application/json",
      "Accept":"application/json"
    });
    final response = usuarioFromJson(resp.body);
    usuarios = response;
    notifyListeners();
    }
}