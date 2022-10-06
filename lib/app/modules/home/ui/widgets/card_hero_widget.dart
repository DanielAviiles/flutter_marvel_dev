import 'package:flutter/material.dart';
import 'package:flutter_marvel_dev/app/modules/home/domain/models/info_character_dom.dart';

class CardHeroWidget extends StatelessWidget {
  const CardHeroWidget({Key? key, required this.character}) : super(key: key);

  final InfoCharacterDom character;

  @override
  Widget build(BuildContext context) {
    double radius = 5.0;
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius))),
      elevation: 30,
      shadowColor: Colors.lightBlueAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius),
            ),
            child: Image.network(
              character.imgUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 120,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8).copyWith(right: 4),
            child: Center(
              child: Text(
                character.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
