import 'package:flutter/material.dart';
import '../models/kaji_record.dart';
import '../services/api_service.dart';
import '../controllers/user_controller.dart';

/// 家事レコード画面：現在のユーザーの記録と獲得ポイントを表示する
class RecordKajiView extends StatefulWidget {
  const RecordKajiView({super.key});

  @override
  State<RecordKajiView> createState() => _RecordKajiViewState();
}

class _RecordKajiViewState extends State<RecordKajiView> {
  late Future<List<KajiRecord>> _futureRecords;

  @override
  void initState() {
    super.initState();
    _futureRecords = ApiService.fetchKajiRecords();
  }

  Future<void> _refresh() async {
    setState(() {
      _futureRecords = ApiService.fetchKajiRecords();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = UserController().currentUser;
    return Scaffold(
      appBar: AppBar(title: const Text('家事レコード')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '現在のポイント: ${currentUser.totalPoints}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<KajiRecord>>(
              future: _futureRecords,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('エラー: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final records = snapshot.data!;
                  if (records.isEmpty) {
                    return const Center(child: Text('記録された家事はありません'));
                  }
                  return RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView.builder(
                      itemCount: records.length,
                      itemBuilder: (context, index) {
                        final record = records[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: ListTile(
                            title: Text(record.kajiTitle ?? '家事ID: ${record.kajiId}'),
                            subtitle: Text('実施日: ${record.performedDate.toLocal().toString().split(" ")[0]}\n担当者: ${record.userName ?? "不明"}'),
                          ),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}