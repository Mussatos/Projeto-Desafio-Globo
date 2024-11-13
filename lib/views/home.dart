import 'package:flutter/material.dart';
import 'package:prova_p2_mobile/api/imdb.api.dart';
import 'package:prova_p2_mobile/components/list_all.dart';
import 'package:prova_p2_mobile/model/list.model.dart';
import 'package:prova_p2_mobile/views/list_favorite_view.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ListModel> movieList = [];

  List<ListModel> tvShowList = [];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ListFavoriteView()),
      );
    }
  }

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
              child: Column(children: [
                ListAll(
                  title: 'Filmes',
                  items: movieList,
                ),
                ListAll(
                  title: 'Séries',
                  items: tvShowList,
                )
              ]),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Minha lista',
          ),
        ],
      ),
    );
  }
}
