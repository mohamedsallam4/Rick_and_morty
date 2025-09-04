import 'package:flutter/material.dart';
import 'package:rickandmorty/Constants/my_colors.dart';
import 'package:rickandmorty/Data/Models/characters.dart';

class CharactersDetailsScreen extends StatefulWidget {
  //todo:::

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
          "${widget.selectedCharacter.name}",
          style: TextStyle(color: MyColors.myWhite),
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

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(color: MyColors.myWhite,fontWeight: FontWeight.bold,fontSize: 18)
          ), TextSpan(
            text: value,
            style: TextStyle(color: MyColors.myWhite,fontSize: 16)
          )
        ]
      ),
    );
  }
Widget buildDivider(double endIndent){
  return Divider(
    color: MyColors.myYellow,
    height: 30,
    endIndent:endIndent ,
    thickness: 2,
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [characterInfo(
                    "Type  :  ",widget.selectedCharacter.status.toString()


                  ), buildDivider(265),
                  characterInfo(
                    "gender  :  ",widget.selectedCharacter.gender.toString()


                  ), buildDivider(250),
         
                  characterInfo(
                    "species  :  ",widget.selectedCharacter.species.toString()


                  ), buildDivider(245),
                  characterInfo(
                    "created  :  ",widget.selectedCharacter.created.toString()


                  ), buildDivider(242),
                  SizedBox(
                    height: 20,

                  )],
                ),
              ),
              SizedBox(
                height:500 ,
              )
            ]),
          ),
        ],
      ),
    );
  }
}
