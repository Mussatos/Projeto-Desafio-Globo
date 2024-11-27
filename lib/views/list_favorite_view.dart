import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prova_p2_mobile/api/imdb.api.dart';
import 'package:prova_p2_mobile/model/item_detail.abstract.model.dart';
import 'package:prova_p2_mobile/model/movie_detail.model.dart';
import 'package:prova_p2_mobile/model/tv_show_detail.model.dart';
import 'package:prova_p2_mobile/views/home.dart';
import 'package:prova_p2_mobile/views/detailed_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListFavoriteView extends StatefulWidget {
  ListFavoriteView({super.key});

  @override
  State<ListFavoriteView> createState() => _ListFavoriteView();
}

class _ListFavoriteView extends State<ListFavoriteView> {
  List<dynamic> favoriteMovies = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds = prefs.getStringList('favorites') ?? [];

    List<dynamic> fetchedMovies = [];
    for (String favorite in favoriteIds) {
      try {
        final item = jsonDecode(favorite);
        if (item['type'] == 'Filmes') {
          final movie = await fetchSingleMovie(int.parse(item['id']));
          if (movie != null) fetchedMovies.add({'item': movie, 'type': item['type']});
        } else {
          final tvShow = await fetchSingleTvShow(int.parse(item['id']));
          if (tvShow != null) fetchedMovies.add({'item': tvShow, 'type': item['type']});
        }
      } catch (err) {
        print("Erro ao buscar filme ou série: $err");
      }
    }

    setState(() {
      favoriteMovies = fetchedMovies;
    });
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(35, 35, 35, 1),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Minha lista',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: favoriteMovies.isEmpty
          ? Center(
              child: Text(
                "Nenhum filme favoritado.",
                style: TextStyle(color: Colors.white),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Quantidade de colunas na grade
                  crossAxisSpacing: 8, // Espaçamento entre colunas
                  mainAxisSpacing: 8, // Espaçamento entre linhas
                  childAspectRatio: 0.7, // Proporção do item
                ),
                itemCount: favoriteMovies.length,
                itemBuilder: (context, index) {
                  final movie = favoriteMovies[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailedView(
                            itemId: movie['item'].id,
                            type:
                                movie['type'], 
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: movie['item'].imageUrl != null &&
                                  movie['item'].imageUrl.isNotEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    'https://image.tmdb.org/t/p/w500/${movie['item'].imageUrl}',
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Icon(Icons.movie,
                                  color: Colors.white, size: 50),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          movie['item'].title ?? "Título desconhecido",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  );
                },
              ),
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
