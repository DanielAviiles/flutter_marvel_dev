import 'package:flutter/material.dart';
import 'package:flutter_marvel_dev/app/modules/detail_comics/domain/models/info_comic_dom.dart';

class CardComicOfCharacter extends StatelessWidget {
  const CardComicOfCharacter({Key? key, required this.comic}) : super(key: key);

  final InfoComicDom comic;

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
              comic.imgUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 120,
              errorBuilder: (ctx, error, _) =>
                  Icon(Icons.image_not_supported_sharp),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8).copyWith(right: 4),
            child: Center(
              child: Text(
                comic.title,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
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
