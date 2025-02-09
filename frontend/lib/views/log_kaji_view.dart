import 'package:flutter/material.dart';
import '../models/kaji.dart';
import '../services/api_service.dart';

/// 家事記録画面：家事データを一覧表示し、タップで記録（家事レコードの作成）を行う
class LogKajiView extends StatefulWidget {
  const LogKajiView({super.key});

  @override
  State<LogKajiView> createState() => _LogKajiViewState();
}

class _LogKajiViewState extends State<LogKajiView> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('家事記録')),
      body: FutureBuilder<List<Kaji>>(
        future: _futureKajis,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('エラー: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final kajis = snapshot.data!;
            if (kajis.isEmpty) {
              return const Center(child: Text('登録された家事がありません'));
            }
            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                itemCount: kajis.length,
                itemBuilder: (context, index) {
                  final kaji = kajis[index];
                  return ListTile(
                    title: Text(kaji.title),
                    subtitle: Text(kaji.content),
                    trailing: Text('${kaji.points} pts'),
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (selectedDate != null) {
                        try {
                          // 仮：ユーザーID を 1 として記録を作成する例
                          await ApiService.createKajiRecord(1, kaji.id, selectedDate);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${kaji.title} を ${selectedDate.toLocal().toString().split(" ")[0]} に記録しました'),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('記録に失敗しました: $e')),
                          );
                        }
                      }
                    },
                  );
                },
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}