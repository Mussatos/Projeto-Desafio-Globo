import 'package:flutter/material.dart';
import 'package:prova_p2_mobile/api/imdb.api.dart';

class DetailedView extends StatelessWidget {
  final int itemId;
  final String type;
  late final Map<String, dynamic> item;
  DetailedView({super.key, required this.itemId, required this.type});

  Future<void> fetchItem() async {
    switch (type) {
      case "Filmes":
        item = await fetchSingleMovie(itemId);
        break;

      case "Séries":
        item = await fetchSingleTvShow(itemId);
        break;

      default:
        print('deu ruim :)');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
        future: fetchItem(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CircularProgressIndicator();
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Image.network(
                      'https://image.tmdb.org/t/p/w200/${item['poster_path']}'),
                ),
                Text(type),
                Text(item['overview'] ?? ''),
                Text(item['title'] ?? ''),
                Text(item['original_title'] ?? ''),
                Text(item['release_date'] ?? ''),
                Text(item['genres'].toString() ?? ''),
                Text(item['origin_country'].toString() ?? '')
              ],
            ),
          );
        },
      ),
    );
  }
}
