import 'package:flutter/material.dart';
import '../controllers/kaji_controller.dart';
import '../models/kaji.dart';

/// 家事記録画面：登録された家事一覧から家事を選択し、実施日時を記録する
class LogKajiView extends StatefulWidget {
  const LogKajiView({super.key});

  @override
  State<LogKajiView> createState() => _LogKajiViewState();
}

class _LogKajiViewState extends State<LogKajiView> {
  // KajiController 経由で家事データを取得
  final KajiController _kajiController = KajiController();

  @override
  Widget build(BuildContext context) {
    final List<Kaji> kajis = _kajiController.kajis;
    return Scaffold(
      appBar: AppBar(
        title: const Text('家事記録'),
      ),
      body: kajis.isEmpty
          ? const Center(child: Text('登録された家事がありません'))
          : ListView.builder(
              itemCount: kajis.length,
              itemBuilder: (context, index) {
                final kaji = kajis[index];
                return ListTile(
                  title: Text(kaji.title),
                  subtitle: Text(kaji.content),
                  trailing: const Icon(Icons.edit),
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (selectedDate != null) {
                      _kajiController.recordKaji(kaji, selectedDate);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              '${kaji.title} を ${selectedDate.toLocal().toString().split(" ")[0]} に記録しました'),
                        ),
                      );
                    }
                  },
                );
              },
            ),
    );
  }
}