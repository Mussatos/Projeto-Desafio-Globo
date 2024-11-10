import 'package:flutter/material.dart';
import 'package:prova_p2_mobile/model/movie_detail.model.dart';

class TechnicalSheetMovie extends StatelessWidget {
  final MovieDetailModel movie;
  const TechnicalSheetMovie({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(35, 35, 35, 1),
      child: Column(
        children: [
          Row(
            children: [Text('Título original: '), Text(movie.originalTitle)],
          ),
          Row(
            children: [Text('Gênero: '), Text(movie.formatGenders())],
          ),
          Row(
            children: [Text('Data de lançameto: '), Text(movie.releaseDate)],
          ),
          Row(
            children: [Text('País: '), Text(movie.originCountry[0])],
          ),
          Row(
            children: [Text('Título original: '), Text(movie.originalTitle)],
          )
        ],
      ),
    );
  }
}
