class Club {
  final String id;
  final String nombre;
  final String estadio;
  final int fundacion;

  Club({
    required this.id,
    required this.nombre,
    required this.estadio,
    required this.fundacion,
  });

  factory Club.fromMap(Map<String, dynamic> data, String documentId) {
    return Club(
      id: documentId,
      nombre: data['nombre'],
      estadio: data['estadio'],
      fundacion: data['fundacion'],
    );
  }

  Map<String, dynamic> toMap(String userId) {
    return {
      'nombre': nombre,
      'estadio': estadio,
      'fundacion': fundacion,
      'userId': userId,
    };
  }
}
