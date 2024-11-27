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

// {
//     "adult": false,
//     "backdrop_path": "/4ErOWmDGyGk0qCK1J8blAoj1a7a.jpg",
//     "created_by": [
//         {
//             "id": 3426999,
//             "credit_id": "6624bd2be295b4014a9977b3",
//             "name": "Inês Gomes",
//             "original_name": "Inês Gomes",
//             "gender": 0,
//             "profile_path": "/1NLJsgicqk4ts6hLU5dxe1bPYov.jpg"
//         },
//         {
//             "id": 3427036,
//             "credit_id": "666d78d8aa37ff453490f128",
//             "name": "Cândida Ribeiro",
//             "original_name": "Cândida Ribeiro",
//             "gender": 0,
//             "profile_path": null
//         }
//     ],
//     "episode_run_time": [
//         50
//     ],
//     "first_air_date": "2024-06-18",
//     "genres": [
//         {
//             "id": 18,
//             "name": "Drama"
//         }
//     ],
//     "homepage": "https://opto.sic.pt/series/a-promessa/9a10f3de-cd20-40a3-97f7-84f528e6e9f7",
//     "id": 252373,
//     "in_production": true,
//     "languages": [
//         "pt"
//     ],
//     "last_air_date": "2024-11-26",
//     "last_episode_to_air": {
//         "id": 5772549,
//         "name": "Episódio 120",
//         "overview": "",
//         "vote_average": 0,
//         "vote_count": 0,
//         "air_date": "2024-11-26",
//         "episode_number": 120,
//         "episode_type": "standard",
//         "production_code": "",
//         "runtime": 68,
//         "season_number": 2,
//         "show_id": 252373,
//         "still_path": "/l5puW1znpam7W0JLMoKaQBVDt7Y.jpg"
//     },
//     "name": "A Promessa",
//     "next_episode_to_air": {
//         "id": 5772550,
//         "name": "Episódio 121",
//         "overview": "",
//         "vote_average": 0,
//         "vote_count": 0,
//         "air_date": "2024-11-27",
//         "episode_number": 121,
//         "episode_type": "standard",
//         "production_code": "",
//         "runtime": 67,
//         "season_number": 2,
//         "show_id": 252373,
//         "still_path": "/l5puW1znpam7W0JLMoKaQBVDt7Y.jpg"
//     },
//     "networks": [
//         {
//             "id": 818,
//             "logo_path": "/iyEiVlVWoA6GHKLuNRpXtnPo2rh.png",
//             "name": "SIC",
//             "origin_country": "PT"
//         },
//         {
//             "id": 4547,
//             "logo_path": "/kaZQkqS9vhowK2P2SlfxYsGKskQ.png",
//             "name": "OPTO",
//             "origin_country": "PT"
//         }
//     ],
//     "number_of_episodes": 123,
//     "number_of_seasons": 2,
//     "origin_country": [
//         "PT"
//     ],
//     "original_language": "pt",
//     "original_name": "A Promessa",
//     "overview": "Será o amor de Laura suficiente para curar o ódio de Miguel e a culpa de Tomás? Será ela capaz de escolher qual dos dois vai salvar?",
//     "popularity": 2560.509,
//     "poster_path": "/uptgxt2apx5wwWItQzqL0HwhjZC.jpg",
//     "production_companies": [
//         {
//             "id": 178845,
//             "logo_path": "/cuhjoXa0Q20pX4uxclXEWh6leOC.png",
//             "name": "Opto SIC",
//             "origin_country": "PT"
//         },
//         {
//             "id": 8413,
//             "logo_path": "/vZokJngHqGwMKJSgIUOky2Ui46a.png",
//             "name": "SIC - Sociedade Independente de Comunicação",
//             "origin_country": "PT"
//         },
//         {
//             "id": 92108,
//             "logo_path": "/ufaY7DMZUz56C6iaIdaFTZDqYPY.png",
//             "name": "SP Televisão",
//             "origin_country": "PT"
//         }
//     ],
//     "production_countries": [
//         {
//             "iso_3166_1": "PT",
//             "name": "Portugal"
//         }
//     ],
//     "seasons": [
//         {
//             "air_date": "2024-06-18",
//             "episode_count": 113,
//             "id": 389495,
//             "name": "Temporada 1",
//             "overview": "",
//             "poster_path": "/d3H6ewqR2GRbus5AEry2jVOCGGd.jpg",
//             "season_number": 1,
//             "vote_average": 1
//         },
//         {
//             "air_date": "2024-11-18",
//             "episode_count": 10,
//             "id": 428853,
//             "name": "Temporada 2",
//             "overview": "",
//             "poster_path": "/p9lyrOTz3Apw8UVg2mbmdaNEHeW.jpg",
//             "season_number": 2,
//             "vote_average": 0
//         }
//     ],
//     "spoken_languages": [
//         {
//             "english_name": "Portuguese",
//             "iso_639_1": "pt",
//             "name": "Português"
//         }
//     ],
//     "status": "Returning Series",
//     "tagline": "",
//     "type": "Scripted",
//     "vote_average": 5.714,
//     "vote_count": 7
// }