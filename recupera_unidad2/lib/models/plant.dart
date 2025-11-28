class Plant {
  final String nombre;
  final String nombreCientifico;
  final String descripcion;
  final String imagen;
  final String cuidados;

  Plant({
    required this.nombre,
    required this.nombreCientifico,
    required this.descripcion,
    required this.imagen,
    required this.cuidados,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      nombre: json['nombre'] ?? '',
      nombreCientifico: json['nombre_cientifico'] ?? json['nombreCientifico'] ?? '',
      descripcion: json['descripcion'] ?? '',
      imagen: json['imagen'] ?? '',
      cuidados: json['cuidados'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'nombreCientifico': nombreCientifico,
      'descripcion': descripcion,
      'imagen': imagen,
      'cuidados': cuidados,
    };
  }
}
