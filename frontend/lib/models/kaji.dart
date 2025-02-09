class Kaji {
  final int id;
  final String title;
  final String content;
  final int points;
  final DateTime? recordedDate;

  Kaji({
    required this.id,
    required this.title,
    required this.content,
    required this.points,
    this.recordedDate,
  });

  factory Kaji.fromJson(Map<String, dynamic> json) {
    return Kaji(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      points: json['points'],
      recordedDate: json['recorded_date'] != null ? DateTime.parse(json['recorded_date']) : null,
    );
  }
}