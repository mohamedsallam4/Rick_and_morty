import 'package:flutter/material.dart';
import 'package:rickandmorty/Constants/my_colors.dart';
import 'package:rickandmorty/Data/Models/singel_char_model.dart';

class CharactersDetailsScreen extends StatefulWidget {
  final Result selectedCharacter;
  const CharactersDetailsScreen({super.key, required this.selectedCharacter});

  @override
  State<CharactersDetailsScreen> createState() =>
      _CharactersDetailsScreenState();
}

class _CharactersDetailsScreenState extends State<CharactersDetailsScreen> {
  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 500,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          widget.selectedCharacter.name ?? "Unknown",
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.start,
        ),
        background: Hero(
          tag: widget.selectedCharacter.id.toString(),
          child: Image.network(
            widget.selectedCharacter.image.toString(),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String? value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: "$title: ",
            style: const TextStyle(
                color: MyColors.myYellow,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          TextSpan(
            text: value ?? "Unknown",
            style: const TextStyle(color: MyColors.myWhite, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: MyColors.myYellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    final character = widget.selectedCharacter;

    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    characterInfo("Status", character.status),
                    buildDivider(260),
                    characterInfo("Species", character.species),
                    buildDivider(250),
                    characterInfo("Type", character.type!.isNotEmpty ? character.type : "Unknown"),
                    buildDivider(275),
                    characterInfo("Gender", character.gender),
                    buildDivider(256),
                    characterInfo("Origin", character.origin?.name),
                    buildDivider(265),
                    characterInfo("Location", character.location?.name),
                    buildDivider(243),
                    characterInfo("Episodes", character.episode.length.toString()),
                    buildDivider(240),
                    characterInfo("Created",
                        character.created?.toLocal().toString().split(' ').first),
                    buildDivider(250),
                  ],
                ),
              ),
              const SizedBox(height: 500),
            ]),
          ),
        ],
      ),
    );
  }
}
