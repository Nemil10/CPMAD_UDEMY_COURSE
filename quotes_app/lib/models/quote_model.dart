class Quote {
  final int? id;
  final String content;
  final String author;

  const Quote({
    this.id,
    required this.content,
    required this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'] is int ? json['id'] as int : null,
      content:
          (json['content'] ?? json['quote'] ?? json['q'] ?? '').toString(),
      author: (json['author'] ?? json['a'] ?? 'Unknown').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'content': content,
      'author': author,
    };
  }

  @override
  String toString() => 'Quote(content: "$content", author: "$author")';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Quote &&
          runtimeType == other.runtimeType &&
          content == other.content &&
          author == other.author;

  @override
  int get hashCode => Object.hash(content, author);
}
