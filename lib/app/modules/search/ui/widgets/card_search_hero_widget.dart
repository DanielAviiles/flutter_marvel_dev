import 'package:flutter/material.dart';
import 'package:flutter_marvel_dev/app/modules/home/domain/models/info_character_dom.dart';

class CardSearchHeroWidget extends StatelessWidget {
  const CardSearchHeroWidget({Key? key, required this.character})
      : super(key: key);

  final InfoCharacterDom character;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 75,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0xffDDDDDD),
              blurRadius: 6.0,
              spreadRadius: 2.0,
              offset: Offset.zero,
            )
          ],
        ),
        child: ListTile(
          leading: Image.network(
            character.imgUrl,
            fit: BoxFit.cover,
            width: 70,
            height: 80,
            errorBuilder: (ctx, error, _) =>
                Icon(Icons.image_not_supported_sharp),
          ),
          title: Text(character.name, style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
