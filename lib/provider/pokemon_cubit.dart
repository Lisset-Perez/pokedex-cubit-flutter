import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_cubit/data/pokemon_data.dart';
import 'package:pokedex_cubit/models/models.dart';

abstract class PokemonState {}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonLoaded extends PokemonState {
  final List<Pokemon> pokemons;
  PokemonLoaded(this.pokemons);
}

class PokemonError extends PokemonState {
  final String message;
  PokemonError(this.message);
}

class PokemonCubit extends Cubit<PokemonState> {
  final PokemonRepository repository;
  PokemonCubit(this.repository) : super(PokemonInitial());

  Future<void> fetchPokemons() async {
    emit(PokemonLoading());
    try {
      final response = await repository.fetchPokemons();
      emit(PokemonLoaded(response.results));
    } catch (e) {
      emit(PokemonError(e.toString()));
    }
  }
}
