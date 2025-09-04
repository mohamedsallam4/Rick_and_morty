import 'package:rickandmorty/Data/Models/characters.dart';
import 'package:rickandmorty/Data/Web_Servise/characters_web_services.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository({required this.charactersWebServices});

  Future<Character> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    try {
      return characters;
    } catch (e) {
      rethrow; // تمرير الاستثناء
    }
  }
}
