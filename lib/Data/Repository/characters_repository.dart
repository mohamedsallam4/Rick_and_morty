import '../Models/characters.dart';
import '../Web_Servise/characters_web_services.dart';

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
