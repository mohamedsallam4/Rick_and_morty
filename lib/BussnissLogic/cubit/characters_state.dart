part of 'characters_cubit.dart';

@immutable
sealed class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<Result> characters;   // <-- هنا مش Character
  CharactersLoaded(this.characters);
}

// class CharactersErrorCase extends CharactersState{}
