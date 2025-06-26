class Pokemons {
  final String name;
  final String imageUrl;

  Pokemons({required this.name, required this.imageUrl});

  factory Pokemons.fromJson(Map<String, dynamic> json) {
    final id = json['url'].toString().split(
      '/',
    )[6]; // Extrae el ID desde la URL del Pokémon
    return Pokemons(
      name: json['name'],
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
    );
  }
}
