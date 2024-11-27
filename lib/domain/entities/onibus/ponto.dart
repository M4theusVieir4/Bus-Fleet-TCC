class Ponto {
  final String ruaAvenida;
  final String bairro;
  final String estado;

  Ponto({
    required this.ruaAvenida,
    required this.bairro,
    required this.estado,
  });

  factory Ponto.fromJson(Map<String, dynamic> json) {
    return Ponto(
      ruaAvenida: json['ruaAvenida'],
      bairro: json['bairro'],
      estado: json['estado'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ruaAvenida': ruaAvenida,
      'bairro': bairro,
      'estado': estado,
    };
  }
}
