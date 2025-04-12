class ArticleModel {
  final String title;
  final String content;
  final String image;

  ArticleModel({
    required this.title,
    required this.content,
    required this.image,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'],
      content: json['content'],
      image: json['image'],
    );
  }
}
