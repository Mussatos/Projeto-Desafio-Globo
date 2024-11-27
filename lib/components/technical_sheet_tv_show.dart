import 'package:flutter/material.dart';
import 'package:prova_p2_mobile/model/movie_detail.model.dart';
import 'package:prova_p2_mobile/model/tv_show_detail.model.dart';

class TechnicalSheetTvShow extends StatelessWidget {
  final TvShowDetailModel movie;
  const TechnicalSheetTvShow({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: Color.fromRGBO(35, 35, 35, 1),
      height: screenHeight * 0.5,
      padding: EdgeInsets.all(16), // Espaçament interno
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Ficha Tecnica',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Título original: ',
                style: TextStyle(
                  color: const Color.fromARGB(255, 177, 169, 169),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                movie.originalTitle,
                style: TextStyle(
                  color: Color.fromARGB(255, 177, 169, 169),
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Gênero: ',
                style: TextStyle(
                  color: Color.fromARGB(255, 177, 169, 169),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                movie.formatGenders(),
                style: TextStyle(
                  color: Color.fromARGB(255, 177, 169, 169),
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Data de lançamento: ',
                style: TextStyle(
                  color: Color.fromARGB(255, 177, 169, 169),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                movie.releaseDate,
                style: TextStyle(
                  color: Color.fromARGB(255, 177, 169, 169),
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                'País: ',
                style: TextStyle(
                  color: Color.fromARGB(255, 177, 169, 169),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                movie.originCountry[0],
                style: TextStyle(
                  color: Color.fromARGB(255, 177, 169, 169),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
