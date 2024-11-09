class ListModel {
  int itemId;
  String imageUrl;

  ListModel({required this.itemId, required this.imageUrl});

  factory ListModel.fromJson(Map<String, dynamic> json) {
    return ListModel(
        itemId: json['id'],
        imageUrl: json['poster_path']
    );
  }
}