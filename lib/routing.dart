import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'BussnissLogic/cubit/characters_cubit.dart';
import 'Constants/strings.dart';
import 'Data/Models/singel_char_model.dart';
import 'Data/Repository/characters_repository.dart';
import 'Data/Web_Servise/characters_web_services.dart';
import 'Presentation/Screens/characters_details_screen.dart';
import 'Presentation/Screens/characters_screen.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;
  AppRouter() {
    charactersRepository = CharactersRepository(
      charactersWebServices: CharactersWebServices(),
    );
    charactersCubit = CharactersCubit(charactersRepository);
  }
  // ignore: body_might_complete_normally_nullable
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => charactersCubit,
            child: CharactersScreen(),
          ),
        );

      case charactersDetailScreen:
        final selectedCharacter = settings.arguments as Result;
        return MaterialPageRoute(
          builder: (context) => CharactersDetailsScreen(selectedCharacter: selectedCharacter,),
        );
    }
  }
}
