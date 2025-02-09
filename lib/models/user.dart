/// ユーザーデータのモデル
class User {
  final int id;
  final String name;
  int totalPoints;

  User({
    required this.id,
    required this.name,
    required this.totalPoints,
  });
}