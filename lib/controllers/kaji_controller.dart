import '../models/kaji.dart';

/// 家事に関するビジネスロジックを担当する Controller
class KajiController {
  // シングルトンパターンでインスタンス管理
  static final KajiController _instance = KajiController._internal();
  factory KajiController() => _instance;
  KajiController._internal();

  // 家事リスト（実際の実装ではデータベースやAPI連携などになる）
  final List<Kaji> _kajis = [];

  List<Kaji> get kajis => _kajis;

  /// 家事の新規登録
  void addKaji(Kaji kaji) {
    _kajis.add(kaji);
    // 必要に応じて通知処理などを実装
  }

  /// 家事の実施記録を登録（ダミー実装）
  void recordKaji(Kaji kaji, DateTime date) {
    // 実際は家事記録用のリストに保存したりする
    print("Kaji recorded: ${kaji.title} on $date");
  }

  /// 合計ポイントを計算（シンプルなサンプル）
  int getTotalPoints() {
    int total = 0;
    for (var kaji in _kajis) {
      total += kaji.points;
    }
    return total;
  }
}