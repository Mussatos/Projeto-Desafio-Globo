import 'package:flutter/material.dart';
import 'package:prova_p2_mobile/api/imdb.api.dart';
import 'package:prova_p2_mobile/components/list_all.dart';
import 'package:prova_p2_mobile/model/list.model.dart';

class Home extends StatelessWidget {
  Home({super.key});

  List<ListModel> movieList = [];
  List<ListModel> tvShowList = [];

  Future<void> fetchLists() async {
    movieList = await listMovies();
    tvShowList = await listTvShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(35, 35, 35, 1),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Globoplay',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600)),
        ),
        body: FutureBuilder(
          future: fetchLists(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            if (snapshot == null)
              return Center(
                child: Text("Não foi possível listar séries e filmes :( )"),
              );
            else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListAll(
                      title: 'Filmes',
                      items: movieList,
                    ),
                    ListAll(
                      title: 'Séries',
                      items: tvShowList,
                    )
                  ],
                ),
              );
            }
          },
        ));
  }
}
