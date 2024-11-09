import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:prova_p2_mobile/model/list.model.dart';

const baseUrl = 'api.themoviedb.org';
const apiKey =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMjA2Zjk5YzlmZjhmMzE0MDUzNzJiZTUwNWRkODQ2MiIsIm5iZiI6MTczMTE3NjU4Ny41NTI1NTg0LCJzdWIiOiI2NzJmYTcxNzVhNjViYjgxOTBkZDJhMzEiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.ySdn-S6G--w2MP91r1239DvFhX2c2T82MugzSv0g5dI';

Uri urlListMovies = Uri.https(baseUrl, '/3/discover/movie');
Uri urlListTvShows = Uri.https(baseUrl, '/3/discover/tv');

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
