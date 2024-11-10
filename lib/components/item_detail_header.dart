import 'dart:ui';

import 'package:flutter/material.dart';

class ItemDetailHeader extends StatelessWidget {
  final String type;
  final String title;
  final String description;
  final String imageUrl;

  ItemDetailHeader(
      {super.key,
      required this.description,
      required this.imageUrl,
      required this.title,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image:
                  NetworkImage('https://image.tmdb.org/t/p/w500/${imageUrl}'),
              fit: BoxFit.cover),
          color: Color.fromRGBO(0, 0, 0, 0.4)),
      child: BackdropFilter(
        filter:
            ImageFilter.blur(sigmaX: 5, sigmaY: 5, tileMode: TileMode.mirror),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(1),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Image.network(
                      'https://image.tmdb.org/t/p/w200/${imageUrl}'),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(type,
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                SizedBox(
                  height: 15,
                ),
                Text(
                  description,
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 16,
                      fontWeight: FontWeight.w400, wordSpacing: 1.25),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
