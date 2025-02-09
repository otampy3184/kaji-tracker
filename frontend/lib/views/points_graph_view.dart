import 'package:flutter/material.dart';
import '../models/kaji.dart';
import '../services/api_service.dart';

/// ポイントグラフ画面：家事データから合計ポイントを計算（ダミー実装）
class PointsGraphView extends StatefulWidget {
  const PointsGraphView({super.key});

  @override
  State<PointsGraphView> createState() => _PointsGraphViewState();
}

class _PointsGraphViewState extends State<PointsGraphView> {
  late Future<List<Kaji>> _futureKajis;

  @override
  void initState() {
    super.initState();
    _futureKajis = ApiService.fetchKajis();
  }

  Future<void> _refresh() async {
    setState(() {
      _futureKajis = ApiService.fetchKajis();
    });
  }

  int _calculateTotalPoints(List<Kaji> kajis) {
    return kajis.fold(0, (sum, item) => sum + item.points);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ポイントグラフ')),
      body: FutureBuilder<List<Kaji>>(
        future: _futureKajis,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('エラー: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final kajis = snapshot.data!;
            final totalPoints = _calculateTotalPoints(kajis);
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bar_chart, size: 100, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(height: 20),
                  Text('合計ポイント: $totalPoints', style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 10),
                  const Text('グラフ表示は未実装'),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refresh,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}