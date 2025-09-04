import 'package:flutter/material.dart';
import 'package:rickandmorty/Constants/my_colors.dart';
import 'package:rickandmorty/Constants/strings.dart';
import 'package:rickandmorty/Data/Models/characters.dart';

class CharacterItem extends StatelessWidget {
  final Result character;
  const CharacterItem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.myGrey,
        borderRadius: BorderRadiusDirectional.circular(8),
        border: Border.all(
          color: Colors.white,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          charactersDetailScreen,
          arguments: character,
        ),
        child: Hero(
          tag: character.id.toString(),
          child: GridTile(
            footer: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                "${character.name}",
                style: const TextStyle(
                    height: 1.3,
                    fontSize: 16,
                    color: MyColors.myWhite,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            child: Container(
              color: MyColors.myGrey,
              child: character.image!.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: "assets/icons/loading.gif",
                      image: character.image!,
                      fit: BoxFit.cover,
                    )
                  : Image.asset("assets/icons/placeholder.gif"),
            ),
          ),
        ),
      ),
    );
  }
}
