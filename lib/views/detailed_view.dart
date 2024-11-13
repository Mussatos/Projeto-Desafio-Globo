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
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder(
        future: fetchItem(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          item = item as MovieDetailModel;
          return SingleChildScrollView(
            child: SizedBox(
               height: screenHeight * 0.9,
              child: Column(
                children: [
                  ItemDetailHeader(
                      description: item.overview,
                      imageUrl: item.imageUrl,
                      title: item.title ?? item.name!,
                      type: type),

                Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => print('clicou'),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.play_arrow,
                                color: Color.fromRGBO(35, 35, 35, 1),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Assista',
                                style: TextStyle(
                                  color: Color.fromRGBO(35, 35, 35, 1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                              ),
                            ),
                            fixedSize: MaterialStateProperty.all(
                                Size.fromHeight(60)),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.all(16)),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),  // Espaço entre os botões
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => print('clicou'),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star,
                                color: Color.fromARGB(255, 177, 169, 169),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Minha Lista',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 177, 169, 169),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                color: Color.fromARGB(255, 177, 169, 169),
                                width: 1,
                              ),
                            ),
                          ),
                          fixedSize: MaterialStateProperty.all(
                              Size.fromHeight(60)),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.all(16)),
                        ),
                      ),
                      ),
                    ]
                  ),
                ),
                // A ficha técnica do filme (sem o Expanded)
                if (type == 'Filmes')
                    TechnicalSheetMovie(movie: item as MovieDetailModel),
             
       
              ])
            ),
          );
  }),
    );}}