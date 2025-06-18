class Article {
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? sourceName;
  final String? publishedAt;

  Article({
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.sourceName,
    this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      description: json['description'], // ✅ parse from JSON
      url: json['url'],
      urlToImage: json['urlToImage'] ?? json['image'],
      sourceName: json['sourceName'] ?? json['source']?['name'],
      publishedAt: json['publishedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description, // ✅ serialize to JSON
      'url': url,
      'urlToImage': urlToImage,
      'sourceName': sourceName,
      'publishedAt': publishedAt,
    };
  }
}
