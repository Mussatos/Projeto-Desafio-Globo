import 'package:flutter/material.dart';
import 'package:prova_p2_mobile/api/imdb.api.dart';
import 'package:prova_p2_mobile/components/list_all.dart';
import 'package:prova_p2_mobile/model/list.model.dart';
import 'package:prova_p2_mobile/views/home.dart';

class ListFavoriteView extends StatefulWidget {
  ListFavoriteView({super.key});

  @override
  State<ListFavoriteView> createState() => _ListFavoriteView();
}

class _ListFavoriteView extends State<ListFavoriteView> {
  List<ListModel> movieList = [];

  List<ListModel> tvShowList = [];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
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
        title: const Text('Minha lista',
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
                children: [],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.white,
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
