import 'package:flutter/material.dart';
import '../models/pokemon.dart';

class PokemonHorizontalList extends StatelessWidget {
  final List<Pokemon> pokemons;
  const PokemonHorizontalList({super.key, required this.pokemons});

  @override
  Widget build(BuildContext context) {
    final h =
        MediaQuery.of(context).size.height *
        0.5; // Para que abarque hasta mitad de pantalla

    return SizedBox(
      height: h + 90, // alto de la imagen + texto y márgenes
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: pokemons.length,
        separatorBuilder: (_, __) => const SizedBox(width: 5),
        itemBuilder: (_, i) {
          final p = pokemons[i];
          return SizedBox(
            width: h * 0.9, // relación 3:4 aprox. para la card
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/images/loading.gif'),
                    image: NetworkImage(p.sprite),
                    width: h * 0.95,
                    height: h, // ⬅️ imagen ocupa la mitad vertical
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  p.name.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    "Habilidad: ${p.abilities.join(', ')}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.indigo),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
