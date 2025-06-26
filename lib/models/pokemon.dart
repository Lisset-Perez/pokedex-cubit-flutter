import 'dart:convert';

class Pokemon {
  final int id;
  final String name;
  final String sprite;
  final List<String> abilities;
  final double weight;

  Pokemon({
    required this.id,
    required this.name,
    required this.sprite,
    required this.abilities,
    required this.weight,
  });

  /// JSON «detalle» de /pokemon/{id}
  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
    id: json['id'],
    name: json['name'],
    sprite:
        json['sprites']['other']['official-artwork']['front_default'] ??
        json['sprites']['front_default'],
    abilities: List<String>.from(
      json['abilities'].map((a) => a['ability']['name']),
    ),
    weight: (json['weight'] as num).toDouble(),
  );

  factory Pokemon.fromRawJson(String str) => Pokemon.fromJson(jsonDecode(str));
}
