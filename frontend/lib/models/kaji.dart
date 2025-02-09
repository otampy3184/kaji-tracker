/// 家事のデータモデル
class Kaji {
  final int id;
  final String title;
  final String content;
  final int points;
  DateTime? recordedDate; // 家事実施日時（任意）

  Kaji({
    required this.id,
    required this.title,
    required this.content,
    required this.points,
    this.recordedDate,
  });
}