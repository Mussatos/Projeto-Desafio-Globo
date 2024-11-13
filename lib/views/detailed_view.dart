import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:prova_p2_mobile/api/imdb.api.dart';
import 'package:prova_p2_mobile/components/item_detail_header.dart';
import 'package:prova_p2_mobile/components/technical_sheet_movie.dart';
import 'package:prova_p2_mobile/model/item_detail.abstract.model.dart';
import 'package:prova_p2_mobile/model/movie_detail.model.dart';

class DetailedView extends StatelessWidget {
  final int itemId;
  final String type;
  late ItemDetail item;
  DetailedView({super.key, required this.itemId, required this.type});

  Future<void> fetchItem() async {
    switch (type) {
      case "Filmes":
        item = await fetchSingleMovie(itemId);
        break;

      case "Séries":
        // item = await fetchSingleTvShow(itemId);
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

          item = item as MovieDetailModel;
          return SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  ItemDetailHeader(
                      description: item.overview,
                      imageUrl: item.imageUrl,
                      title: item.title ?? item.name!,
                      type: type),
                  Container(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () => print('clicou'),
                              child: Text('btn-1')),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                              onPressed: () => print('clicou'),
                              child: Text('btn-2')),
                        ],
                      ),
                    ),
                  ),
                   if (type == 'Filmes')
                     TechnicalSheetMovie(movie: item as MovieDetailModel)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
