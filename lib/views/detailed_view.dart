import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:prova_p2_mobile/api/imdb.api.dart';
import 'package:prova_p2_mobile/components/item_detail_header.dart';
import 'package:prova_p2_mobile/components/technical_sheet_movie.dart';
import 'package:prova_p2_mobile/components/technical_sheet_tv_show.dart';
import 'package:prova_p2_mobile/model/item_detail.abstract.model.dart';
import 'package:prova_p2_mobile/model/list.model.dart';
import 'package:prova_p2_mobile/model/movie_detail.model.dart';
import 'package:prova_p2_mobile/model/tv_show_detail.model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailedView extends StatefulWidget {
  final int itemId;
  final String type;
  DetailedView({Key? key, required this.itemId, required this.type})
      : super(key: key);

  @override
  _DetailedViewState createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView>
    with SingleTickerProviderStateMixin {
  late ItemDetail item;
  late TabController _tabController;
  bool isAdded = false;
  bool isLoading = false;
  bool isLoadingTabBar = false;
  List<ListModel> movies = [];
  List<ListModel> series = [];

  @override
  void initState() {
    super.initState();
    fetchItem();
    fetchMovies();
    _tabController = TabController(length: 2, vsync: this);
    checkIfFavorite();
  }

  Future<void> fetchItem() async {
    setState(() {
      isLoading = true;
    });
    try {
      switch (widget.type) {
        case "Filmes":
          item = await fetchSingleMovie(widget.itemId);
          break;
        case "Séries":
          item = await fetchSingleTvShow(widget.itemId);
          break;
        default:
          print('Erro ao carregar dados.');
      }
    } catch (e) {
      print('Erro ao buscar item: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchMovies() async {
    setState(() {
      isLoadingTabBar = true;
    });
    try {
      movies = await listMovies();
      series = await listTvShows();
    } catch (e) {
      print('Erro ao buscar filmes ou séries: $e');
    } finally {
      setState(() {
        isLoadingTabBar = false;
      });
    }
  }

  Future<void> checkIfFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteMovies = prefs.getStringList('favorites') ?? [];
    setState(() {
      isAdded = favoriteMovies.map((item) {
        final decode = jsonDecode(item);
        return decode['id'];
      }).contains(widget.itemId.toString());
    });
  }

  void toggleButton() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteMovies = prefs.getStringList('favorites') ?? [];

    setState(() {
      if (isAdded) {
        String itemToRemove =
            jsonEncode({'id': widget.itemId.toString(), 'type': widget.type});
        favoriteMovies.remove(itemToRemove);
      } else {
        String item =
            jsonEncode({'id': widget.itemId.toString(), 'type': widget.type});
        favoriteMovies.add(item);
      }
      isAdded = !isAdded;
    });

    await prefs.setStringList('favorites', favoriteMovies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  ItemDetailHeader(
                    description: item.overview,
                    imageUrl: item.imageUrl,
                    title: item.title ?? item.name!,
                    type: widget.type,
                  ),
                  Container(
                    color: Colors.black,
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
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
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(16)),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: toggleButton,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: isAdded
                                      ? Colors.yellow
                                      : Color.fromARGB(255, 177, 169, 169),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  isAdded ? 'Adicionado' : 'Minha Lista',
                                  style: TextStyle(
                                    color: isAdded
                                        ? Colors.yellow
                                        : Color.fromARGB(255, 177, 169, 169),
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
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(16)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.black,
                    child: TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.white,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey,
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      dividerColor: Colors.transparent,
                      tabs: [
                        Tab(
                            child: Text(
                          'Assista Também',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                        Tab(
                          child: Text(
                            'Detalhes',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Color.fromRGBO(35, 35, 35, 1),
                    height: MediaQuery.of(context).size.height * 0.5,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: isLoadingTabBar
                        ? const CircularProgressIndicator()
                        : TabBarView(
                            controller: _tabController,
                            children: [
                              GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 0.6,
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 8.0,
                                ),
                                itemCount: (widget.type == 'Filmes'
                                    ? movies
                                        .where((rec) =>
                                            rec.itemId != widget.itemId)
                                        .length
                                    : series
                                        .where((rec) =>
                                            rec.itemId != widget.itemId)
                                        .length),
                                itemBuilder: (context, index) {
                                  final rec = (widget.type == 'Filmes'
                                      ? movies
                                          .where((rec) =>
                                              rec.itemId != widget.itemId)
                                          .toList()[index]
                                      : series
                                          .where((rec) =>
                                              rec.itemId != widget.itemId)
                                          .toList()[index]);
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailedView(
                                              itemId: rec.itemId,
                                              type: widget.type),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      child: Image.network(
                                        'https://image.tmdb.org/t/p/w500/${rec.imageUrl}',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    if (widget.type == 'Filmes')
                                      TechnicalSheetMovie(
                                          movie: item as MovieDetailModel)
                                    else if (widget.type == 'Séries')
                                      TechnicalSheetTvShow(
                                          movie: item as TvShowDetailModel),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
