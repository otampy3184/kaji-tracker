class KajiRecord {
  final int id;
  final int userId;
  final int kajiId;
  final DateTime performedDate;
  final String? userName;   // JOIN によって取得したユーザー名
  final String? kajiTitle;  // JOIN によって取得した家事タイトル

  KajiRecord({
    required this.id,
    required this.userId,
    required this.kajiId,
    required this.performedDate,
    this.userName,
    this.kajiTitle,
  });

  factory KajiRecord.fromJson(Map<String, dynamic> json) {
    return KajiRecord(
      id: json['id'],
      userId: json['user_id'],
      kajiId: json['kaji_id'],
      performedDate: DateTime.parse(json['performed_date']),
      userName: json['user_name'],
      kajiTitle: json['kaji_title'],
    );
  }
}