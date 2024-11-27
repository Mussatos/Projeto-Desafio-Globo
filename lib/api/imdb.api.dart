import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:prova_p2_mobile/model/list.model.dart';
import 'package:prova_p2_mobile/model/movie_detail.model.dart';

const baseUrl = 'api.themoviedb.org';
const apiKey =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMjA2Zjk5YzlmZjhmMzE0MDUzNzJiZTUwNWRkODQ2MiIsIm5iZiI6MTczMTE3NjU4Ny41NTI1NTg0LCJzdWIiOiI2NzJmYTcxNzVhNjViYjgxOTBkZDJhMzEiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.ySdn-S6G--w2MP91r1239DvFhX2c2T82MugzSv0g5dI';

Uri urlListMovies =
    Uri.https(baseUrl, '/3/discover/movie', {'language': 'pt-br'});
Uri urlListTvShows =
    Uri.https(baseUrl, '/3/discover/tv', {'language': 'pt-br'});

Future<List<ListModel>> listMovies() async {
  try {
    final response = await http.get(urlListMovies, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $apiKey',
    });

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['results'];
      return data.map((json) => ListModel.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  } catch (err) {
    return [];
  }
}

Future<List<ListModel>> listTvShows() async {
  try {
    final response = await http.get(urlListTvShows, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $apiKey',
    });

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['results'];
      return data.map((json) => ListModel.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  } catch (err) {
    print(err);
    return [];
  }
}

Future<void> listMoviesWithCategory() async {}

Future<void> listTvShowWithCategory() async {}

Future<MovieDetailModel> fetchSingleMovie(int movieId) async {
  Uri urlMovieDetail =
      Uri.https(baseUrl, '/3/movie/${movieId}', {'language': 'pt-br'});
  try {
    final response = await http.get(urlMovieDetail, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $apiKey',
    });

    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception();
    }
  } catch (err) {
    print(err);
    return MovieDetailModel(
        id: 0,
        genres: [],
        imageUrl: '',
        originCountry: [],
        originalTitle: '',
        overview: '',
        releaseDate: '',
        title: '');
  }
}

Future<Map<String, dynamic>> fetchSingleTvShow(int tvShowId) async {
  Uri urlMovieDetail =
      Uri.https(baseUrl, '/3/tv/${tvShowId}', {'language': 'pt-br'});
  try {
    final response = await http.get(urlMovieDetail, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $apiKey',
    });

    if (response.statusCode == 200) {
      final tvShow = jsonDecode(response.body);
      return tvShow;
    } else {
      throw Exception();
    }
  } catch (err) {
    print(err);
    return {};
  }
}

Future<void> fetchMovieCredits(String movieId) async {
  Uri urlMovieCredits =
      Uri.https(baseUrl, '/3/movie/${movieId}/credits', {'language': 'pt-br'});
}

Future<void> fetchTvShowCredits(String tvShowId) async {
  Uri urlTvShowCredits =
      Uri.https(baseUrl, '/3/tc/${tvShowId}/credits', {'language': 'pt-br'});
}
