 

import 'char_info_model.dart';
import 'singel_char_model.dart';

class Character {
    Character({
        required this.info,
        required this.results,
    });

    final Info? info;
    final List<Result> results;

    factory Character.fromJson(Map<String, dynamic> json){ 
        return Character(
            info: json["info"] == null ? null : Info.fromJson(json["info"]),
            results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
        );
    }

}

