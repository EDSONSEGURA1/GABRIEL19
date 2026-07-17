class Jugador {
  final String id;
  final String nombre;
  final int edad;
  final String posicion;
  final String clubId;
  final String nombreClub; // Añadido para mostrar en la lista de fichajes

  Jugador({
    required this.id,
    required this.nombre,
    required this.edad,
    required this.posicion,
    required this.clubId,
    this.nombreClub = 'Sin Club', // Valor por defecto
  });

  factory Jugador.fromMap(Map<String, dynamic> data, String documentId) {
    return Jugador(
      id: documentId,
      nombre: data['nombre'] ?? '',
      edad: data['edad'] ?? 0,
      posicion: data['posicion'] ?? '',
      clubId: data['clubId'] ?? '',
      nombreClub: data['nombreClub'] ?? 'Sin Club',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'edad': edad,
      'posicion': posicion,
      'clubId': clubId,
      'nombreClub': nombreClub,
    };
  }
}
