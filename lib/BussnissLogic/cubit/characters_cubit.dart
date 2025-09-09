
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Data/Models/singel_char_model.dart';
import '../../Data/Repository/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;   

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  Future<void> getAllCharacters() async {
    final character = await charactersRepository.getAllCharacters();
    emit(CharactersLoaded(character.results)); // results = List<Result>
  }
}


