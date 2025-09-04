import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rickandmorty/Data/Models/characters.dart';
import 'package:rickandmorty/Data/Repository/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;   

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  Future<void> getAllCharacters() async {
    final character = await charactersRepository.getAllCharacters();
    emit(CharactersLoaded(character.results)); // results = List<Result>
  }
}


