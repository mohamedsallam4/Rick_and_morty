import 'package:dio/dio.dart';
import 'package:rickandmorty/Constants/strings.dart';
import 'package:rickandmorty/Data/Models/characters.dart';

class CharactersWebServices {
  late Dio dio;
  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,

      connectTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20),
    );
    dio = Dio(options);
  }
  Future<Character> getAllCharacters() async {
    try {
      final response = await dio.get("character"); // endpoint
      if (response.statusCode == 200) {
        return Character.fromJson(response.data);
      } else {
        throw Exception("فشل في جلب البيانات: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Dio Error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected Error: $e");
    }
  }
}

