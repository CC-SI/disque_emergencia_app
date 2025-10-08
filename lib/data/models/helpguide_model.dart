class HelpGuide {
  final int id;
  final String title;
  final String category;
  final String coverImage;
  final String content;

  HelpGuide({
    required this.id,
    required this.title,
    required this.category,
    required this.coverImage,
    required this.content,
  });

  factory HelpGuide.fromJson(Map<String, dynamic> json) {
    return HelpGuide(
      id: json['id'] as int,
      title: json['title'] as String,
      category: json['category'] as String,
      coverImage: json['cover_image'] as String,
      content: json['content'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'cover_image': coverImage,
      'content': content,
    };
  }
}