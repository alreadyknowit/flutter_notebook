class TextModel {
  final int id;
  final String title;
  final String article;
  final int colorIndex;
  TextModel({this.id, this.article, this.title, this.colorIndex});

  Map<String, dynamic> toMap() {
    return {'id': id, 'article': article, 'title': title, 'colorIndex': colorIndex};
  }
}
