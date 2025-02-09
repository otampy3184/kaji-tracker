class User {
  final int id;
  final String name;
  int totalPoints;

  User({
    required this.id,
    required this.name,
    required this.totalPoints,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      totalPoints: json['total_points'] ?? 0,
    );
  }
}