import 'package:flutter/material.dart';
import '../controllers/kaji_controller.dart';
import '../controllers/user_controller.dart';
import '../models/kaji.dart';
import '../models/user.dart';

/// 家事レコード画面：現在のユーザーが実施した家事の記録と獲得ポイントを表示する
class RecordKajiView extends StatefulWidget {
  const RecordKajiView({super.key});

  @override
  State<RecordKajiView> createState() => _RecordKajiViewState();
}

class _RecordKajiViewState extends State<RecordKajiView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('家事レコード')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '現在のポイント: ${UserController().currentUser.totalPoints}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: KajiController().kajis.length,
              itemBuilder: (context, index) {
                final kaji = KajiController().kajis[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    title: Text(kaji.title),
                    subtitle: Text(kaji.content),
                    trailing: Text('${kaji.points} pts',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(context, MaterialPageRoute(builder: (context) => const NewKajiView()));
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
