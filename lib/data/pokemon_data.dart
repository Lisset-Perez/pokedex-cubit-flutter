import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon.dart';
import '../models/pokemon_response.dart';

class PokemonRepository {
  final _base = 'https://pokeapi.co/api/v2/pokemon';

  Future<PokemonResponse> fetchPokemons({int limit = 20}) async {
    // llamada paginada
    final listRes = await http.get(Uri.parse('$_base?limit=$limit'));
    if (listRes.statusCode != 200) throw Exception('Error lista');

    final raw = jsonDecode(listRes.body);
    final paged = PokemonResponse.fromJson(raw); // count/next/previous

    // para cada nombre+url, pedimos DETALLE y sacamos abilities
    final futures = (raw['results'] as List).map((b) async {
      final dRes = await http.get(Uri.parse(b['url']));
      if (dRes.statusCode != 200) throw Exception('Error ${b['name']}');
      return Pokemon.fromRawJson(dRes.body); // ⬅️ abilities incluidas
    }).toList();

    final fullList = await Future.wait(futures);

    // devolvemos la misma cabecera con results completos
    return paged.copyWith(results: fullList);
  }
}
