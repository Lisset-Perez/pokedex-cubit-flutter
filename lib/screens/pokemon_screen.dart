import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_cubit/provider/pokemon_cubit.dart';
import 'package:pokedex_cubit/widgets/pokemon_lista.dart';

class PokemonListScreen extends StatelessWidget {
  const PokemonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/pokebolla.png', height: 60),
            const SizedBox(width: 8),
            const Text('Pokédex', style: TextStyle(fontSize: 26)),
          ],
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<PokemonCubit, PokemonState>(
        builder: (_, state) {
          if (state is PokemonLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PokemonLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Image.asset('assets/images/pokemon.jpg'),
                  const SizedBox(height: 20),
                  PokemonHorizontalList(pokemons: state.pokemons),
                ],
              ),
            );
          } else if (state is PokemonError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
