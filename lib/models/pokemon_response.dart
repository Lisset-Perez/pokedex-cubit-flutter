import 'dart:convert';
import 'pokemon.dart';

/// Representa la respuesta paginada de https://pokeapi.co/api/v2/pokemon
class PokemonResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<Pokemon> results;

  PokemonResponse({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  /// Recibe JSON crudo de la primera llamada (lista)
  factory PokemonResponse.fromRawJson(String str) =>
      PokemonResponse.fromJson(jsonDecode(str));

  factory PokemonResponse.fromJson(Map<String, dynamic> json) =>
      PokemonResponse(
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        // En results sólo vienen name+url; rellenamos luego en repo
        results: const [], // se sustituirá con la lista completa
      );

  PokemonResponse copyWith({List<Pokemon>? results}) => PokemonResponse(
    count: count,
    next: next,
    previous: previous,
    results: results ?? this.results,
  );
}
