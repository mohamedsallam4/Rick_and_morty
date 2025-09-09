import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../BussnissLogic/cubit/characters_cubit.dart';
import '../../Constants/my_colors.dart';
import '../../Data/Models/singel_char_model.dart';
import '../Widgets/charater_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Result> allCharacters;
  late List<Result> searchedForCharacters;
  bool isSearching = false;
  final searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  /// TextField الخاص بالبحث
  Widget buildSearchField() {
    return TextField(
      controller: searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
        hintText: "Find a character...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
      ),
      style: TextStyle(color: MyColors.myGrey, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }

  /// فلترة النتائج
  void addSearchedForItemsToSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharacters
        .where(
          (character) => character.name!.toLowerCase().contains(
            searchedCharacter.toLowerCase(),
          ),
        )
        .toList();
    setState(() {});
  }

  /// أزرار الـ AppBar
  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear, color: MyColors.myGrey),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            startSearch();
          },
          icon: Icon(Icons.search, color: MyColors.myGrey),
        ),
      ];
    }
  }

  /// بدأ البحث
  void startSearch() {
    ModalRoute.of(
      context,
    )!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));
    setState(() {
      isSearching = true;
    });
  }

  /// إيقاف البحث
  void stopSearching() {
    clearSearch();
    setState(() {
      isSearching = false;
    });
  }

  /// مسح البحث
  void clearSearch() {
    setState(() {
      searchTextController.clear();
    });
  }

  /// Bloc Builder
  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = state.characters;
          return buildLoadedListWidgets();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  /// Loader
  Widget showLoadingIndicator() {
    return Center(child: CircularProgressIndicator(color: MyColors.myYellow));
  }

  /// الـ Widgets بعد التحميل
  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(children: [buildCharactersList()]),
      ),
    );
  }

  /// GridView للشخصيات
  Widget buildCharactersList() {
    final listToShow = searchTextController.text.isEmpty
        ? allCharacters
        : searchedForCharacters;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: listToShow.length,
      itemBuilder: (BuildContext context, int index) {
        return CharacterItem(character: listToShow[index]);
      },
    );
  }

  /// عنوان الـ AppBar
  Widget buildAppBarTitle() {
    return Text("Characters", style: TextStyle(color: MyColors.myGrey));
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: const Color.fromARGB(255, 222, 214, 163),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              "Can't Connect ... check internet",
              style: TextStyle(fontSize: 22, color: MyColors.myGrey),
            ),SizedBox(
              height: 10,
            ),
            Image.asset("assets/icons/placeholder.gif"),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: isSearching ? buildSearchField() : buildAppBarTitle(),
        actions: buildAppBarActions(),
        leading: isSearching
            ? BackButton(color: MyColors.myGrey)
            : const SizedBox.shrink(),
      ),
      body: OfflineBuilder(
        connectivityBuilder:
            (
              BuildContext context,
              List<ConnectivityResult> connectivity,
              Widget child,
            ) {
              final bool connected = !connectivity.contains(
                ConnectivityResult.none,
              );
              if (connected) {
                return buildBlocWidget();
              } else {
                return buildNoInternetWidget();
              }
            },
        child: showLoadingIndicator(),
      ),
    );
  }
}
