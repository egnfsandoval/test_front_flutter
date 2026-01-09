// To parse this JSON data, do
//
//     final usuarios = usuariosFromJson(jsonString);

import 'dart:convert';

List<Usuarios> usuariosFromJson(String str) => List<Usuarios>.from(json.decode(str).map((x) => Usuarios.fromJson(x)));
Usuarios usuarioFromJson(String str) => Usuarios.fromJson(json.decode(str));
String usuariosToJson(Usuarios data) => json.encode(data.toJson());

class Usuarios {
    final int id;
    final String nombre1;
    final String? nombre2;
    final String apellido1;
    final String? apellido2;
    final String email;
    final String password;
    final int activo;
    final DateTime fechaCreacion;
    final DateTime fechaActualizacion;

    Usuarios({
        required this.id,
        required this.nombre1,
        required this.nombre2,
        required this.apellido1,
        required this.apellido2,
        required this.email,
        required this.password,
        required this.activo,
        required this.fechaCreacion,
        required this.fechaActualizacion,
    });

    factory Usuarios.fromJson(Map<String, dynamic> json) => Usuarios(
        id: json["id"],
        nombre1: json["nombre1"],
        nombre2: json["nombre2"],
        apellido1: json["apellido1"],
        apellido2: json["apellido2"],
        email: json["email"],
        password: json["password"],
        activo: json["activo"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fechaActualizacion: DateTime.parse(json["fechaActualizacion"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre1": nombre1,
        "nombre2": nombre2,
        "apellido1": apellido1,
        "apellido2": apellido2,
        "email": email,
        "password": password,
        "activo": activo,
        "fechaCreacion": fechaCreacion.toIso8601String(),
        "fechaActualizacion": fechaActualizacion.toIso8601String(),
    };
}
