// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

List<Usuario> usuarioFromJson(String str) => List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

String usuarioToJson(List<Usuario> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usuario {
    String id;
    String ubicacion;
    String zona;
    String stand;
    String col;
    String fil;
    String cantidad;
    String img;

    Usuario({
        required this.id,
        required this.ubicacion,
        required this.zona,
        required this.stand,
        required this.col,
        required this.fil,
        required this.cantidad,
        required this.img,
    });

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        ubicacion: json["Ubicacion"],
        zona: json["Zona"],
        stand: json["Stand"],
        col: json["col"],
        fil: json["fil"],
        cantidad: json["Cantidad"],
        img: json["Img"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "Ubicacion": ubicacion,
        "Zona": zona,
        "Stand": stand,
        "col": col,
        "fil": fil,
        "Cantidad": cantidad,
        "Img": img,
    };
}
