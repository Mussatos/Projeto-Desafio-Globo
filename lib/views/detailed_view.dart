import 'package:flutter/material.dart';
import 'package:prova_p2_mobile/api/imdb.api.dart';
import 'package:prova_p2_mobile/components/item_detail_header.dart';
import 'package:prova_p2_mobile/components/technical_sheet_movie.dart';
import 'package:prova_p2_mobile/model/item_detail.abstract.model.dart';
import 'package:prova_p2_mobile/model/movie_detail.model.dart';

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchItem();
  }

  Future<void> fetchItem() async {
    switch (widget.type) {
      case "Filmes":
        item = await fetchSingleMovie(widget.itemId);
        break;
      case "Séries":
        // item = await fetchSingleTvShow(itemId);
        break;
      default:
        print('Erro ao carregar dados.');
    }
    setState(() {}); // Atualizar a interface após carregar o item
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: item == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                ItemDetailHeader(
                  description: item.overview,
                  imageUrl: item.imageUrl,
                  title: item.title ?? item.name!,
                  type: widget.type,
                ),
                // Botões "Assista" e "Minha Lista"
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
                            fixedSize:
                                MaterialStateProperty.all(Size.fromHeight(60)),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(16)),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
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
                            fixedSize:
                                MaterialStateProperty.all(Size.fromHeight(60)),
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
                      Tab( child: Text('Assista Também', style: TextStyle(fontSize: 18, color: Colors.white),)),
                      Tab(child: Text('Detalhes', style: TextStyle(fontSize: 18, color: Colors.white),),),
                    ],
                  ),
                ),

                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Aba de "Assista Também"
                      Text('Filmes relacionados',
                          style: TextStyle(color: Colors.black)),

                      //ABA DETALHES
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            if (widget.type == 'Filmes')
                              TechnicalSheetMovie(
                                  movie: item as MovieDetailModel),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
