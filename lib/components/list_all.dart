import 'package:flutter/material.dart';
import 'package:prova_p2_mobile/model/list.model.dart';
import 'package:prova_p2_mobile/views/detailed_view.dart';

class ListAll extends StatelessWidget {
  String title;
  List<ListModel> items;
  ListAll({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                ListModel item = items[index];
                return GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 16, 0),
                    child: Image.network(
                        'https://image.tmdb.org/t/p/w500/${item.imageUrl}'),
                  ),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailedView(itemId: item.itemId, type: title))),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
