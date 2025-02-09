class Kaji {
  final int id;
  final String title;
  final String content;
  final int points;
  final DateTime? createdAt;

  Kaji({
    required this.id,
    required this.title,
    required this.content,
    required this.points,
    this.createdAt,
  });

  factory Kaji.fromJson(Map<String, dynamic> json) {
    return Kaji(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      points: json['points'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }
}