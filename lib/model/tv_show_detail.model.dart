import 'package:prova_p2_mobile/model/item_detail.abstract.model.dart';

class TvShowDetailModel extends ItemDetail {
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
  int? id;

  TvShowDetailModel(
      {required this.genres,
      required this.originCountry,
      required this.originalTitle,
      required this.overview,
      required this.releaseDate,
      required this.title,
      required this.imageUrl,
      required this.id})
      : super();

  String formatGenders() {
    return genres.map((genre) => genre['name']).join(', ');
  }

  factory TvShowDetailModel.fromJson(Map<String, dynamic> json) {
    return TvShowDetailModel(
        id: json['id'] ?? 0,
        overview: json['overview'] ?? '',
        title: json['name'] ?? '',
        originalTitle: json['original_name'] ?? '',
        releaseDate: json['first_air_date'] ?? '',
        genres: json['genres'] ?? [''],
        originCountry: json['origin_country'] ?? [''],
        imageUrl: json['poster_path'] ?? '');
  }
}