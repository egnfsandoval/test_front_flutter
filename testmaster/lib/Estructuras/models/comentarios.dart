import 'dart:convert';
List<Comentarios> comentariosFromJson(String str) => List<Comentarios>.from(json.decode(str).map((x) => Comentarios.fromJson(x)));
Comentarios comentarioFromJson(String str) => Comentarios.fromJson(json.decode(str));
String comentariosToJson(Comentarios data) => json.encode(data.toJson());

class Comentarios {
    final int id;
    final String contenido;
    final int usuarioId;
    final DateTime fechaCreacion;
    final DateTime fechaActualizacion;

    Comentarios({
        required this.id,
        required this.contenido,
        required this.usuarioId,
        required this.fechaCreacion,
        required this.fechaActualizacion,
    });

    factory Comentarios.fromJson(Map<String, dynamic> json) => Comentarios(
        id: json["id"],
        contenido: json["contenido"],
        usuarioId: json["usuario_id"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fechaActualizacion: DateTime.parse(json["fechaActualizacion"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "contenido": contenido,
        "usuario_id": usuarioId,
        "fechaCreacion": fechaCreacion.toIso8601String(),
        "fechaActualizacion": fechaActualizacion.toIso8601String(),
    };
}
