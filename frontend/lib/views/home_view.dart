import 'package:flutter/material.dart';
import 'new_kaji_view.dart';
import 'log_kaji_view.dart';
import 'record_kaji_view.dart';
import 'points_graph_view.dart';

/// ホーム画面：主要機能（家事登録、家事記録、ポイントグラフ、家事レコード）をグリッド表示
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  final List<_HomeFunction> functions = const [
    _HomeFunction(title: '家事登録', icon: Icons.note_add),
    _HomeFunction(title: '家事記録', icon: Icons.edit_calendar),
    _HomeFunction(title: 'ポイントグラフ', icon: Icons.bar_chart),
    _HomeFunction(title: '家事レコード', icon: Icons.list),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🧹📕'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: functions.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final func = functions[index];
            return GestureDetector(
              onTap: () {
                if (func.title == '家事登録') {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const NewKajiView()));
                } else if (func.title == '家事記録') {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const LogKajiView()));
                } else if (func.title == 'ポイントグラフ') {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const PointsGraphView()));
                } else if (func.title == '家事レコード') {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const RecordKajiView()));
                }
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(func.icon, size: 50, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(height: 10),
                      Text(func.title, style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _HomeFunction {
  final String title;
  final IconData icon;

  const _HomeFunction({required this.title, required this.icon});
}