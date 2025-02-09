import 'package:flutter/material.dart';
import '../controllers/kaji_controller.dart';

/// 獲得ポイントのグラフ表示画面（ダミー実装）
class PointsGraphView extends StatelessWidget {
  const PointsGraphView({super.key});

  @override
  Widget build(BuildContext context) {
    // 合計ポイントを Controller 経由で取得
    final int totalPoints = KajiController().getTotalPoints();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ポイントグラフ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bar_chart,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 20),
            Text(
              '合計ポイント: $totalPoints',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            const Text('グラフ表示は未実装'),
          ],
        ),
      ),
    );
  }
}