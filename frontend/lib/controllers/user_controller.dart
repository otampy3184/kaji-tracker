import '../models/user.dart';

/// ユーザーに関するロジックを担当する Controller（必要に応じて拡張）
class UserController {
  static final UserController _instance = UserController._internal();
  factory UserController() => _instance;
  UserController._internal();

  // ダミーのユーザー情報（実際は認証処理などと連携）
  User currentUser = User(id: 1, name: 'User', totalPoints: 0);

  /// ポイントの更新（家事実施時に加算するなど）
  void updatePoints(int points) {
    currentUser.totalPoints += points;
  }
}