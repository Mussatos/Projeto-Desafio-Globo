import 'package:prova_p2_mobile/model/item_detail.abstract.model.dart';

class MovieDetailModel extends ItemDetail {
  @override
  String overview;
  @override
  String? title;
  String originalTitle;
  String releaseDate;
  @override
  String imageUrl;
  List genres;
  List originCountry;

  MovieDetailModel(
      {required this.genres,
      required this.originCountry,
      required this.originalTitle,
      required this.overview,
      required this.releaseDate,
      required this.title,
      required this.imageUrl}) : super();

  String formatGenders() {
    return genres.map((genre) => genre['name']).join(', ');
  }

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
        overview: json['overview'] ?? '',
        title: json['title'] ?? '',
        originalTitle: json['original_title'] ?? '',
        releaseDate: json['release_date'] ?? '',
        genres: json['genres'] ?? [''],
        originCountry: json['origin_country'] ?? [''],
        imageUrl: json['poster_path'] ?? '');
  }
}
