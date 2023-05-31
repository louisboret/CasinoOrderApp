import 'package:flutter/material.dart';

class Thumbnail extends StatefulWidget {
  Thumbnail({super.key, 
  required this.image,
  required this.gameRoute,
  });

  final String image;
  final String gameRoute;

  @override
  State<Thumbnail> createState() => _ThumbnailState();
}

class _ThumbnailState extends State<Thumbnail> {
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, widget.gameRoute);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(8.0))),
          child: SizedBox(
              width: 170,
              height: 170,
              child: Image.asset(widget.image)),
        ),
      ),
    );
  }
}
